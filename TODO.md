### Technical Debt
* Update [external_database_schema.sql](db%2Fexternal_database_schema.sql)
* Fix `DEPRECATION WARNING: !render.view_component`
* Fix `warning: parser/current is loading parser/ruby30, which recognizes 3.0.6-compliant syntax, but you are running 3.0.4.`
* Update Ruby
* Update Rails
* Switch to standardrb and fix issues

### Test Coverage
* Test PotentialDuplication.fix!
* Test `with_similar_item_description` when string > 255 characters
* Test `with_similar_category`

### Bugs
* nil values when using format method e.g. `format('%g', item_size)`

### Potential ProductIssues
* Missing Translation
* Mispelled Brand (Check Brand Alias for fix)
* Mispelled Word (Check Dictionary and Abbreviations for fix)
* Incorrect Item Pack (Check Item Pack Alias for fix)
* Incorrect Item Measure (Check Item Measure Alias for fix)

### Other
* scope :managed to use `master`
* `add_new_products` in scheduled_updates.rake
* Additional filters e.g. has_duplicates on Products
* UI for DictionaryEntry and Abbreviations