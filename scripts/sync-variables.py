#!/usr/bin/env python

import os
import hcl2
import re
import argparse
import logging
from jinja2 import Environment, FileSystemLoader

def filter_terraform_type(value):
    # Currently there is a limition in handling Terraform complex types
    #   https://github.com/amplify-education/python-hcl2/issues/179
    #   https://github.com/amplify-education/python-hcl2/issues/172
    if isinstance(value, str):
        return re.sub(r'\${(.*)}', r'\1', value)
    return value

def filter_terraform_default(value):
    if isinstance(value, bool):
        return str(value).lower()

    if isinstance(value, str):
        if value == "":
            return '\\"\\"'

    if value == None:
        return 'null'

    return re.sub(r'\'', r'\\"', str(value))

def get_template():
    env = Environment(loader=FileSystemLoader("."))
    env.filters['terraform_type'] = filter_terraform_type
    env.filters['terraform_default'] = filter_terraform_default

    return env.from_string("""# IMPORTANT: This file is synced with the "terraform-aws-eks-universal-addon" module. Any changes to this file might be overwritten upon the next release of that module.
{%- for variable in variables %}
{%- for name, spec in variable.items() %}
{%- if name != 'enabled' %}
variable "{{ name }}" {
  type        = {{ spec.type | terraform_type }}
  default     = null
  description = "{{ spec.description }}{% if spec.default is defined %} Defaults to `{{ spec.default | terraform_default }}`.{% endif %}"
}
{%- endif %}
{%- endfor %}
{% endfor %}
""")

def get_logger(args):
    log_level = args.log.upper()

    numeric_level = getattr(logging, log_level, None)
    if not isinstance(numeric_level, int):
        raise ValueError('Invalid log level `%s`' % log_level)

    logging.basicConfig(format='%(levelname)s: %(message)s', level=numeric_level)

    return logging.getLogger(__name__)

def main(args):
    log = get_logger(args)
    log.info("Syncing variables from Terraform modules...")
    log.warning("Terraform variable complex types are NOT supported!")

    template = get_template()

    for module in os.listdir('.terraform/modules'): # Iterate over all initialized modules
        if not module.startswith('addon') or module.find(".") != -1: # Skip non-addon modules, ie. nested modules
            log.info("Skipping module `%s`", module)
            continue

        log.info("Processing module `%s`", module)

        source = '.terraform/modules/'+module+'/modules/'+module+'/variables.tf'
        target = 'variables-'+module+'.tf'

        with open(source, 'r') as f:
            log.info("Reading variables from `%s`", source)

            variables = hcl2.load(f).get('variable')
            log.info("Collected variables: %d", len(variables))
            log.debug(variables)

            with open(target, "w") as f:
                log.info("Writing variables to `%s`", target)
                f.write(template.render(variables=variables))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Sync Terraform variables from the local addon modules to proxy variable files')
    parser.add_argument('--log', default='INFO', help='Set the logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL)')

    args = parser.parse_args()

    main(args)
