# dbt_twitter_source v0.7.1

[PR #]() includes the following updates:
## Bug Fixes
- This package now leverages the new `twitter_ads_extract_url_parameter()` for use in parsing out url parameters. This was added to create special logic for Databricks instances not supported by `dbt_utils.get_url_parameter()`.
  - This macro will be replaced with the `fivetran_utils.extract_url_parameter()` in the next breaking change.
## Under the Hood
- Included auto-releaser GitHub Actions workflow to automate future releases.

# dbt_twitter_source v0.7.0
[PR #22](https://github.com/fivetran/dbt_twitter_source/pull/22) includes the following updates:
## Feature update 🎉
- Unioning capability! This adds the ability to union source data from multiple twitter connectors. Refer to the [Union Multiple Connectors README section](https://github.com/fivetran/dbt_twitter_source/blob/main/README.md#union-multiple-connectors) for more details.

## Under the hood 🚘
- Updated tmp models to union source data using the `fivetran_utils.union_data` macro. 
- To distinguish which source each field comes from, added `source_relation` column in each staging model and applied the `fivetran_utils.source_relation` macro.
- Updated tests to account for the new `source_relation` column.

[PR #19](https://github.com/fivetran/dbt_twitter_source/pull/19) includes the following updates:
- Incorporated the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job.
- Updated the pull request [templates](/.github).

# dbt_twitter_source v0.6.0

## 🚨 Breaking Changes 🚨:
[PR #16](https://github.com/fivetran/dbt_twitter_source/pull/16) includes the following breaking changes:
- Dispatch update for dbt-utils to dbt-core cross-db macros migration. Specifically `{{ dbt_utils.<macro> }}` have been updated to `{{ dbt.<macro> }}` for the below macros:
    - `any_value`
    - `bool_or`
    - `cast_bool_to_text`
    - `concat`
    - `date_trunc`
    - `dateadd`
    - `datediff`
    - `escape_single_quotes`
    - `except`
    - `hash`
    - `intersect`
    - `last_day`
    - `length`
    - `listagg`
    - `position`
    - `replace`
    - `right`
    - `safe_cast`
    - `split_part`
    - `string_literal`
    - `type_bigint`
    - `type_float`
    - `type_int`
    - `type_numeric`
    - `type_string`
    - `type_timestamp`
    - `array_append`
    - `array_concat`
    - `array_construct`
- For `current_timestamp` and `current_timestamp_in_utc` macros, the dispatch AND the macro names have been updated to the below, respectively:
    - `dbt.current_timestamp_backcompat`
    - `dbt.current_timestamp_in_utc_backcompat`
- Dependencies on `fivetran/fivetran_utils` have been upgraded, previously `[">=0.3.0", "<0.4.0"]` now `[">=0.4.0", "<0.5.0"]`.


# dbt_twitter_source v0.5.1

## Fixes
- Fix the package name in the README ([#18](https://github.com/fivetran/dbt_twitter_source/pull/18))

## Feature Enhancement
- Addition of the `keyword_id` surrogate key within the `stg_twitter_ads__line_item_keywords_report`. This field is a combination of the account_id, line_item_id, segment, and placement fields. ([#17](https://github.com/fivetran/dbt_twitter_source/pull/17))

## Under the Hood
- Buildkite testing integration. ([#17](https://github.com/fivetran/dbt_twitter_source/pull/17))

## Contributors
- [@johnf](https://github.com/johnf) ([#18](https://github.com/fivetran/dbt_twitter_source/pull/18))


# dbt_twitter_source v0.5.0

## 🎉 Feature Enhancements 🎉
PR [#13](https://github.com/fivetran/dbt_twitter_source/pull/13) includes the following changes:
- Addition of the following staging models which pull from the source counterparts. The inclusion of the additional `_report` source tables is to generate a more accurate representation of the Twitter Ads data:
  - `stg_twitter_ads__line_item_report`
  - `stg_twitter_ads__account_report`
  - `stg_twitter_ads__campaign_report`
  - `stg_twitter_ads__line_item_keywords_report`: This can be disabled by setting the `twitter_ads__using_keywords` variable to `False`.
  - `stg_twitter_ads__tweet`

- Inclusion of passthrough metrics:
  - `twitter_ads__line_item_report_passthrough_metrics`
  - `twitter_ads__campaign_report_passthrough_metrics`
  - `twitter_ads__line_item_keywords_report_passthrough_metrics`
  - `twitter_ads__promoted_tweet_report_passthrough_metrics`
> This applies to all passthrough columns within the `dbt_twitter_source` package and not just the `twitter_ads__line_item_report_passthrough_metrics` example.
```yml
vars:
  twitter_ads__line_item_report_passthrough_metrics:
    - name: "my_field_to_include" # Required: Name of the field within the source.
      alias: "field_alias" # Optional: If you wish to alias the field within the staging model.
```

- README updates for easier navigation and use of the package.
- Addition of identifier variables for each of the source tables to allow for further flexibility in source table direction within the dbt project.
- Addition of grain uniqueness tests for each staging table.

# dbt_twitter_source v0.4.1
## Fixes
- Changes the partition order for the following models so that the `is_latest_version` flag identifies the last updated row.
  - models/stg_twitter_ads__account_history.sql
  - models/stg_twitter_ads__campaign_history.sql
  - models/stg_twitter_ads__line_item_history.sql
  - models/stg_twitter_ads__promoted_tweet_history.sql
## Contributors
- [@dlubawy](https://github.com/dlubawy) ([#15](https://github.com/fivetran/dbt_twitter_source/pull/15))


# dbt_twitter_source v0.4.0
🎉 dbt v1.0.0 Compatibility 🎉
## 🚨 Breaking Changes 🚨
- Adjusts the `require-dbt-version` to now be within the range [">=1.0.0", "<2.0.0"]. Additionally, the package has been updated for dbt v1.0.0 compatibility. If you are using a dbt version <1.0.0, you will need to upgrade in order to leverage the latest version of the package.
  - For help upgrading your package, I recommend reviewing this GitHub repo's Release Notes on what changes have been implemented since your last upgrade.
  - For help upgrading your dbt project to dbt v1.0.0, I recommend reviewing dbt-labs [upgrading to 1.0.0 docs](https://docs.getdbt.com/docs/guides/migration-guide/upgrading-to-1-0-0) for more details on what changes must be made.
- Upgrades the package dependency to refer to the latest `dbt_fivetran_utils`. The latest `dbt_fivetran_utils` package also has a dependency on `dbt_utils` [">=0.8.0", "<0.9.0"].
  - Please note, if you are installing a version of `dbt_utils` in your `packages.yml` that is not in the range above then you will encounter a package dependency error.

# dbt_twitter_source v0.1.0 -> v0.3.0
Refer to the relevant release notes on the Github repository for specific details for the previous releases. Thank you!
