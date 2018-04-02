#!/usr/bin/python


from jinja2 import Environment, FileSystemLoader
import os

# Capture our current directory
THIS_DIR = os.path.dirname(os.path.abspath(__file__))

def print_html_doc():
    # Create the jinja2 environment.
    # Notice the use of trim_blocks, which greatly helps control whitespace.
    j2_env = Environment(loader=FileSystemLoader(THIS_DIR),
                         trim_blocks=True)
    if os.getenv('PREFIX') != "" :
        myprefix=os.getenv('PREFIX') + '-' 

    print j2_env.get_template('snort-template.conf').render(
        prefix=myprefix
    )

if __name__ == '__main__':
    print_html_doc()

