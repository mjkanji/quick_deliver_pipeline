from dagster import Definitions, load_assets_from_modules
from dagster_dbt import DbtCliResource

from . import assets
from .assets import dbt_project_assets
from .project import dbt_project

all_assets = load_assets_from_modules([assets])

defs = Definitions(
    assets=[
        dbt_project_assets,
    ],
    resources={"dbt": DbtCliResource(project_dir=dbt_project)},
)
