# dbt_twitter_source v0.10.1

This release includes the following updates:

## Bug Fixes

- Updated `stg_twitter_ads__campaign_locations_report` and `stg_twitter_ads__campaign_regions_report` to coalesce `segment` with `segment_name`, as `segment` was renamed to `segment_name` in the `CAMPAIGN_LOCATIONS_REPORT` and `CAMPAIGN_REGIONS_REPORT` source tables in [June 2023](https://fivetran.com/docs/connectors/applications/twitter-ads/changelog#june2023) for most users. ([PR #33](https://github.com/fivetran/dbt_twitter_source/pull/33))
  - In v0.9.0 and v0.10.0 of the package, most users likely had null `country` and `region` values, which this release resolves.

### Under the Hood - July 2025 Updates

- Updated relevant seed files, docs, and the `get_campaign_locations_report()` and `get_campaign_regions_report()` macros to test and support the above inclusion of `segment_name`. ([PR #33](https://github.com/fivetran/dbt_twitter_source/pull/33))
- Updated conditions in `.github/workflows/auto-release.yml`. ([PR #32](https://github.com/fivetran/dbt_twitter_source/pull/32))
- Added `.github/workflows/generate-docs.yml`. ([PR #32](https://github.com/fivetran/dbt_twitter_source/pull/32))
- Migrated `flags` (e.g., `send_anonymous_usage_stats`, `use_colors`) from `sample.profiles.yml` to `integration_tests/dbt_project.yml`. ([PR #32](https://github.com/fivetran/dbt_twitter_source/pull/32))
- Standardized README Quickstart-compatible badge set. ([PR #32](https://github.com/fivetran/dbt_twitter_source/pull/32))
- Updated Python image version to `3.10.13` in `pipeline.yml`. ([PR #32](https://github.com/fivetran/dbt_twitter_source/pull/32))
- Updated `.gitignore` to exclude additional DBT, Python, and system artifacts. ([PR #32](https://github.com/fivetran/dbt_twitter_source/pull/32))

# dbt_twitter_source v0.10.0

[PR #31](https://github.com/fivetran/dbt_twitter_source/pull/31) includes the following updates:

## Breaking Change for dbt Core < 1.9.6
> *Note: This is not relevant to Fivetran Quickstart users.*

Migrated `freshness` from a top-level source property to a source `config` in alignment with [recent updates](https://github.com/dbt-labs/dbt-core/issues/11506) from dbt Core. This will resolve the following deprecation warning that users running dbt >= 1.9.6 may have received:

```
[WARNING]: Deprecated functionality
Found `freshness` as a top-level property of `twitter_ads` in file
`models/src_twitter_ads.yml`. The `freshness` top-level property should be moved
into the `config` of `twitter_ads`.
```

**IMPORTANT:** Users running dbt Core < 1.9.6 will not be able to utilize freshness tests in this release or any subsequent releases, as older versions of dbt will not recognize freshness as a source `config` and therefore not run the tests.

If you are using dbt Core < 1.9.6 and want to continue running Twitter Ads freshness tests, please elect **one** of the following options:
  1. (Recommended) Upgrade to dbt Core >= 1.9.6
  2. Do not upgrade your installed version of the `twitter_ads_source` package. Pin your dependency on v0.9.0 in your `packages.yml` file.
  3. Utilize a dbt [override](https://docs.getdbt.com/reference/resource-properties/overrides) to overwrite the package's `twitter_ads` source and apply freshness via the [old](https://github.com/fivetran/dbt_twitter_source/blob/v0.9.0/models/src_twitter_ads.yml#L10-L12) top-level property route. This will require you to copy and paste the entirety of the `src_twitter_ads.yml` [file](https://github.com/fivetran/dbt_twitter_source/blob/v0.9.0/models/src_twitter_ads.yml#L4-L710) and add an `overrides: twitter_ads_source` property.

## Under the Hood
- Updated the package maintainer PR template.

# dbt_twitter_source v0.9.0

## Schema Changes
**4 total changes • 0 possible breaking changes**
| **Model** | **Change type** | **Old name** | **New name** | **Notes** |
| ---------------- | --------------- | ------------ | ------------ | --------- |
| stg_twitter_ads__campaign_locations_report | New Model |   |   |  Uses `campaign_locations_report` source table  |
| stg_twitter_ads__campaign_locations_report_tmp | New Model |   |   | Uses `campaign_locations_report` source table   |
| stg_twitter_ads__campaign_regions_report | New Model |   |   |  Uses `campaign_regions_report` source table  |
| stg_twitter_ads__campaign_regions_report_tmp | New Model |   |   | Uses `campaign_regions_report` source table   |

## Feature Updates
- Added the `twitter_ads__using_campaign_locations_report` and `twitter_ads__using_campaign_regions_report` variables, which can be used to enable or disable the above transformations related to the `campaign_locations_report` and `campaign_regions_report` tables. ([#30](https://github.com/fivetran/dbt_twitter_source/pull/30))
  - These variables are dynamically set for Fivetran Quickstart users, but **false** by default otherwise. See [README](https://github.com/fivetran/dbt_twitter_source?tab=readme-ov-file#country-and-region-reports) for more details.
- Introduced the `twitter_ads__campaign_locations_report_passthrough_metrics` and `twitter_ads__campaign_regions_report_passthrough_metrics` passthrough column variables, which can be used to pass through additional metrics fields from their respective source reports to downstream models. See [README](https://github.com/fivetran/dbt_twitter_source?tab=readme-ov-file#passing-through-additional-metrics) for more details. ([#30](https://github.com/fivetran/dbt_twitter_source/pull/30))

## Documentation
- Corrected references to connectors and connections in the README. ([#29](https://github.com/fivetran/dbt_twitter_source/pull/29))
- Adjusted header format in the README. ([#30](https://github.com/fivetran/dbt_twitter_source/pull/30))
- Updated LICENSE. ([#30](https://github.com/fivetran/dbt_twitter_source/pull/30))

# dbt_twitter_source v0.8.0

[PR #27](https://github.com/fivetran/dbt_twitter_source/pull/27) includes the following **BREAKING CHANGE** updates:

## Feature Updates: Native Conversion Support
We have added more robust support for conversions in our data models by doing the following:
- Created the `twitter_ads__conversion_fields` and `twitter_ads__conversion_sale_amount_fields` variables to pass through conversion metrics (total number and monetary value, respectively). Conversion metrics are split into these 2 variables due to the N:1 relationship between Twitter conversions and their conversion value fields. 
  - By default, `twitter_ads__conversion_fields` will include `conversion_purchases_metric` and `conversion_custom_metric`.
  - By default, `twitter_ads__conversion_sale_amount_fields` will include `conversion_purchases_sale_amount` and `conversion_custom_sale_amount`.
  - These conversion fields will now populate in the following models:
    - `stg_twitter_ads__campaign_report`
    - `stg_twitter_ads__line_item_keywords_report`
    - `stg_twitter_ads__line_item_report`
    - `stg_twitter_ads__promoted_tweet_report`
  - See [README](https://github.com/fivetran/dbt_twitter_source?tab=readme-ov-file#customizing-types-of-conversions) for more details on how to configure these variables.
  - See the parallel [release](https://github.com/fivetran/dbt_twitter/releases/tag/v0.8.0) of `twitter_ads` for details on how these variables are summed together and leveraged in downstream transformations.

## Under the Hood
- Ensured the above changes maintain backwards compatibility with [existing passthrough column variables](https://github.com/fivetran/dbt_twitter_source?tab=readme-ov-file#passing-through-additional-metrics).
  - Created macros to check whether these fields are already being brought in via existing passthrough variables and ensure there are no duplicate column errors.

## Documentation
- Highlighted all metrics included in the package by default. Previously, `url_clicks` and `spend_micro` were missing from this README [section](https://github.com/fivetran/dbt_twitter_source?tab=readme-ov-file#passing-through-additional-metrics).
- Documented how to configure the new `twitter_ads__conversion_fields` and `twitter_ads__conversion_sale_amount_fields` variables [here](https://github.com/fivetran/dbt_twitter_source?tab=readme-ov-file#customizing-types-of-conversions).
- Added Contributors [subsection](https://github.com/fivetran/dbt_twitter_source?tab=readme-ov-file#contributors) to README.
- Document commonly used conversion fields in yml.

## Contributors
- [Seer Interactive](https://www.seerinteractive.com/?utm_campaign=Fivetran%20%7C%20Models&utm_source=Fivetran&utm_medium=Fivetran%20Documentation)

# dbt_twitter_source v0.7.1

[PR #25](https://github.com/fivetran/dbt_twitter_source/pull/25) includes the following updates:
## Bug Fixes
- This package now leverages the new `twitter_ads_extract_url_parameter()` macro for use in parsing out url parameters. This was added to create special logic for Databricks instances not supported by `dbt_utils.get_url_parameter()`.
  - This macro will be replaced with the `fivetran_utils.extract_url_parameter()` macro in the next breaking change of this package.
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
