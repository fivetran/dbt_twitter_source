# Twitter Ads Source dbt Package ([Docs](https://fivetran.github.io/dbt_twitter_source/))

<p align="left">
    <a alt="License"
        href="https://github.com/fivetran/dbt_twitter_source/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_Core™_version->=1.3.0_,<2.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
</p>

## What does this dbt package do?
- Materializes [Twitter Ads staging tables](https://fivetran.github.io/dbt_twitter_source/#!/overview/twitter_source/models/?g_v=1&g_e=seeds) which leverage data in the format described by [this ERD](https://fivetran.com/docs/applications/twitter-ads#schemainformation). These staging tables clean, test, and prepare your Twitter Ads data from [Fivetran's connector](https://fivetran.com/docs/applications/twitter-ads) for analysis by doing the following:
  - Name columns for consistency across all packages and for easier analysis
  - Adds freshness tests to source data
    > dbt Core >= 1.9.6 is required to run freshness tests out of the box. See other options [here](https://github.com/fivetran/dbt_twitter_source/blob/main/CHANGELOG.md#breaking-change-for-dbt-core--196).
  - Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
- Generates a comprehensive data dictionary of your Twitter Ads data through the [dbt docs site](https://fivetran.github.io/dbt_twitter_source/).
- These tables are designed to work simultaneously with our [Twitter Ads transformation package](https://github.com/fivetran/dbt_twitter).

## How do I use the dbt package?
### Step 1: Prerequisites
To use this dbt package, you must have the following:
- At least one Fivetran Twitter Ads connection syncing data into your destination.
- A **BigQuery**, **Snowflake**, **Redshift**, **PostgreSQL**, or **Databricks** destination.

#### Databricks Dispatch Configuration
If you are using a Databricks destination with this package you will need to add the below (or a variation of the below) dispatch configuration within your `dbt_project.yml`. This is required in order for the package to accurately search for macros within the `dbt-labs/spark_utils` then the `dbt-labs/dbt_utils` packages respectively.
```yml
dispatch:
  - macro_namespace: dbt_utils
    search_order: ['spark_utils', 'dbt_utils']
```

### Step 2: Install the package (skip if also using the `twitter_ads` or `ad_reporting` transformation package)
If you are **not** using the downstream [Twitter Ads](https://github.com/fivetran/dbt_twitter_ads) transformation package and/or [Ad Reporting](https://github.com/fivetran/dbt_ad_reporting) combination package, include the following `twitter_source` package version in your `packages.yml` file.
> TIP: Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

```yml
# packages.yml
packages:
  - package: fivetran/twitter_ads_source
    version: [">=0.10.0", "<0.11.0"] # we recommend using ranges to capture non-breaking changes automatically
```

### Step 3: Define database and schema variables
By default, this package runs using your destination and the `twitter_ads` schema. If this is not where your Twitter Ads data is (for example, if your twitter schema is named `twitter_fivetran`), add the following configuration to your root `dbt_project.yml` file:

```yml
# dbt_project.yml
vars:
    twitter_ads_schema: your_schema_name
    twitter_ads_database: your_destination_name 
```

### Step 4: Disabling or Enabling Models
#### Keywords
This package takes into consideration that not every Twitter Ads account tracks `keyword` performance, and allows you to disable the corresponding functionality by adding the following variable configuration:
```yml
# dbt_project.yml
vars:
    twitter_ads__using_keywords: False # Default = true. Dynamically set for you if using the Twitter Ads transform package via Fivetran Quickstart
```

#### Country and Region Reports
This package uses the `campaign_locations_report` and `campaign_regions_report` [pre-built](https://fivetran.com/docs/connectors/applications/twitter-ads#campaigntables) reports, but takes into consideration that not every user may use these tables.

If you are running the Twitter Ads transform package via Fivetran Quickstart, transformations of the above tables will be dynamically enabled or disabled. Otherwise, transformations of these tables are **disabled** by default.

To enable transformations of the above geo-focused campaign reports, add the following variable configurations to your root `dbt_project.yml` file:

```yml
# dbt_project.yml
vars:
  twitter_ads__using_campaign_locations_report: True # False by default. Will enable/disable use of the `campaign_locations_report`
  twitter_ads__using_campaign_regions_report: True # False by default. Will enable/disable use of the `campaign_regions_report`
```

### (Optional) Step 5: Additional configurations
<details open><summary>Expand/Collapse details</summary>

#### Union multiple connections
If you have multiple twitter ads connections in Fivetran and would like to use this package on all of them simultaneously, we have provided functionality to do so. The package will union all of the data together and pass the unioned table into the transformations. You will be able to see which source it came from in the `source_relation` column of each model. To use this functionality, you will need to set either the `twitter_ads_union_schemas` OR `twitter_ads_union_databases` variables (cannot do both) in your root `dbt_project.yml` file:

```yml
vars:
    twitter_ads_union_schemas: ['twitter_usa','twitter_canada'] # use this if the data is in different schemas/datasets of the same database/project
    twitter_ads_union_databases: ['twitter_usa','twitter_canada'] # use this if the data is in different databases/projects but uses the same schema name
```
> NOTE: The native `source.yml` connection set up in the package will not function when the union schema/database feature is utilized. Although the data will be correctly combined, you will not observe the sources linked to the package models in the Directed Acyclic Graph (DAG). This happens because the package includes only one defined `source.yml`.

To connect your multiple schema/database sources to the package models, follow the steps outlined in the [Union Data Defined Sources Configuration](https://github.com/fivetran/dbt_fivetran_utils/tree/releases/v0.4.latest#union_data-source) section of the Fivetran Utils documentation for the union_data macro. This will ensure a proper configuration and correct visualization of connections in the DAG.

#### Customizing Types of Conversions
The package will include conversion metrics provided to the following variables:

| Variable    | Definition | Default Values |
| -------- | -------- | -------- |
| `twitter_ads__conversion_fields`  | Which fields should be included in calculating total number of conversions. | `conversion_purchases_metric`, `conversion_custom_metric` |
| `twitter_ads__conversion_sale_amount_fields` |  Which `*_sale_amount` fields should be included in calculating the total value of conversions.  | `conversion_purchases_sale_amount`, `conversion_custom_sale_amount` |

By default, the data models include purchases and custom conversion events in both variables. However, you can configure each to include any types of conversions available in the Twitter Ads source `*_report` tables:

```yml
# dbt_project.yml
vars:
    twitter_ads__conversion_fields:
        - conversion_purchases_metric
        - conversion_sign_ups_metric
        - mobile_conversion_payment_info_additions_post_engagement
        - mobile_conversion_add_to_wishlists_post_engagement
        - mobile_conversion_add_to_carts_post_engagement
        - mobile_conversion_checkouts_initiated_post_engagement
        - <any conversion field you want to include>
    twitter_ads__conversion_sale_amount_fields: 
        - conversion_purchases_sale_amount
        - conversion_sign_ups_sale_amount
        - <any conversion value/sale amount field you want to include>
```

> We recommend using the same *types* of conversion events for `twitter_ads__conversion_fields` and `twitter_ads__conversion_sale_amount_fields` (especially if using the `twitter_ads` [transformation package](https://github.com/fivetran/dbt_twitter)), but this is not required. We chose to split conversions and conversion values into 2 distinct variables due to the N:1 relationship beteen conversions and conversion value fields.

#### Passing Through Additional Metrics
In addition to the above conversion fields, this package by default will select `clicks`, `url_clicks`, `impressions`, `spend` (calculated from `billed_charge_local_micro`), and `spend_micro` (aliased from `billed_charge_local_micro`) from the source reporting tables to store into the staging models. If you would like to pass through additional metrics to the staging models, add the below configurations to your `dbt_project.yml` file. These variables allow for the pass-through fields to be aliased (`alias`) if desired, but not required. Use the below format for declaring the respective pass-through variables:

> IMPORTANT: Make sure to exercise due diligence when adding metrics to these models. The metrics added by default (taps, impressions, spend, and conversions) have been vetted by the Fivetran team, maintaining this package for accuracy. There are metrics included within the source reports, such as metric averages, which may be inaccurately represented at the grain for reports created in this package. You must ensure that whichever metrics you pass through are appropriate to aggregate at the respective reporting levels in this package.

```yml
# dbt_project.yml
vars:
    twitter_ads__campaign_report_passthrough_metrics: 
        - name: "new_custom_field"
          alias: "custom_field"
    twitter_ads__line_item_report_passthrough_metrics: 
        - name: "unique_int_field"
          alias: "field_id"
    twitter_ads__line_item_keywords_report_passthrough_metrics: 
        - name: "that_field"
    twitter_ads__promoted_tweet_report_passthrough_metrics: 
        - name: "that_field"
    twitter_ads__campaign_locations_report_passthrough_metrics: 
        - name: "that_field"
    twitter_ads__campaign_regions_report_passthrough_metrics: 
        - name: "that_field"
```

#### Change the build schema
By default, this package builds the Twitter Ads staging models within a schema titled (`<target_schema>` + `_twitter_ads_source`) in your destination. If this is not where you would like your Twitter staging data to be written to, add the following configuration to your root `dbt_project.yml` file:

```yml
# dbt_project.yml
models:
    twitter_ads_source:
        +schema: my_new_schema_name # leave blank for just the target_schema
```

#### Change the source table references
If an individual source table has a different name than the package expects, add the table name as it appears in your destination to the respective variable:
> IMPORTANT: See this project's [`dbt_project.yml`](https://github.com/fivetran/dbt_twitter_source/blob/main/dbt_project.yml) variable declarations to see the expected names.

```yml
# dbt_project.yml
vars:
    twitter_ads_<default_source_table_name>_identifier: your_table_name 
```

</details>

### (Optional) Step 6: Orchestrate your models with Fivetran Transformations for dbt Core™
<details><summary>Expand for details</summary>
<br>

Fivetran offers the ability for you to orchestrate your dbt project through [Fivetran Transformations for dbt Core™](https://fivetran.com/docs/transformations/dbt). Learn how to set up your project for orchestration through Fivetran in our [Transformations for dbt Core™ setup guides](https://fivetran.com/docs/transformations/dbt#setupguide).

</details>

## Does this package have dependencies?
This dbt package is dependent on the following dbt packages. These dependencies are installed by default within this package. For more information on the following packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
> IMPORTANT: If you have any of these dependent packages in your own `packages.yml` file, we highly recommend that you remove them from your root `packages.yml` to avoid package version conflicts.

```yml
packages:
    - package: fivetran/fivetran_utils
      version: [">=0.4.0", "<0.5.0"]
    - package: dbt-labs/dbt_utils
      version: [">=1.0.0", "<2.0.0"]
    - package: dbt-labs/spark_utils
      version: [">=0.3.0", "<0.4.0"]
```

## How is this package maintained and can I contribute?
### Package Maintenance
The Fivetran team maintaining this package _only_ maintains the latest version of the package. We highly recommend that you stay consistent with the [latest version](https://hub.getdbt.com/fivetran/twitter_ads_source/latest/) of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_twitter_source/blob/main/CHANGELOG.md) and release notes for more information on changes across versions.

### Contributions
A small team of analytics engineers at Fivetran develops these dbt packages. However, the packages are made better by community contributions.

We highly encourage and welcome contributions to this package. Check out [this dbt Discourse article](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) on the best workflow for contributing to a package.

#### Contributors
We thank [everyone](https://github.com/fivetran/dbt_twitter_source/graphs/contributors) who has taken the time to contribute. Each PR, bug report, and feature request has made this package better and is truly appreciated.

A special thank you to [Seer Interactive](https://www.seerinteractive.com/?utm_campaign=Fivetran%20%7C%20Models&utm_source=Fivetran&utm_medium=Fivetran%20Documentation), who we closely collaborated with to introduce native conversion support to our Ad packages.

## Are there any resources available?
- If you have questions or want to reach out for help, see the [GitHub Issue](https://github.com/fivetran/dbt_twitter_source/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran or would like to request a new dbt package, fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).
