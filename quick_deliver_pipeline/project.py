from pathlib import Path

from dagster_dbt import DbtProject

DBT_PROJECT_PATH = Path(__file__).joinpath("..", "..", "dbt_project").resolve()

dbt_project = DbtProject(
    project_dir=DBT_PROJECT_PATH,
    packaged_project_dir=Path(__file__).joinpath("..", "..", "dbt-project").resolve(),
)
dbt_project.prepare_if_dev()
