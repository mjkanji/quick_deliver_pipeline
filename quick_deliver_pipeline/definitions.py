from typing import Any, Mapping

from dagster import (
    AssetExecutionContext,
    AssetKey,
    Definitions,
    load_assets_from_modules,
)
from dagster_dbt import (
    DagsterDbtTranslator,
    DbtCliResource,
    dbt_assets,
)

from . import assets
from .project import dbt_project


class CustomDagsterDbtTranslator(DagsterDbtTranslator):
    def get_asset_key(self, dbt_resource_props: Mapping[str, Any]) -> AssetKey:
        asset_key = super().get_asset_key(dbt_resource_props)

        if dbt_resource_props["resource_type"] == "model":
            asset_key = asset_key.with_prefix(["duckdb", "dbt_schema"])
        if dbt_resource_props["resource_type"] == "source":
            asset_key = asset_key.with_prefix("duckdb")

        return asset_key


@dbt_assets(
    manifest=dbt_project.manifest_path,
    dagster_dbt_translator=CustomDagsterDbtTranslator(),
)
def dbt_project_assets(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["run"], context=context).stream()
    yield from dbt.cli(["test"], context=context).stream()


all_assets = load_assets_from_modules([assets], group_name="sources")


defs = Definitions(
    assets=[
        dbt_project_assets,
        *all_assets,
    ],
    resources={"dbt": DbtCliResource(project_dir=dbt_project)},
)
