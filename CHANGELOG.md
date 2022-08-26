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
