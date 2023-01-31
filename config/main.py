"""
This simple script is used to define jinja variables from environment
variables. See the followin links for more info about this file:

https://mkdocs-macros-plugin.readthedocs.io/en/latest/#create-your-own-macros-and-filters
"""

import os

environement_vars = [
    "LECTURE_SHOW",
    "EXAM_SHOW_OBJECTIVES",
    "EXERCISE_SHOW_DATA",
    "EXERCISE_SHOW_SOLUTION",
    "ASSIGNMENT_SHOW_DATA",
    "ASSIGNMENT_SHOW_SOLUTION",
]


def define_env(env):
    for i in environement_vars:
        env.variables[i.lower()] = float(os.getenv(i) or 0)
