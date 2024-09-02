from setuptools import find_packages, setup

setup(
    name="quick_deliver",
    packages=find_packages(exclude=["quick_deliver_tests"]),
    install_requires=[
        "dagster",
        "dagster-cloud"
    ],
    extras_require={"dev": ["dagster-webserver", "pytest"]},
)
