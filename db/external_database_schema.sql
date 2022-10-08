create table if not exists goods_products
(
    id serial not null
        constraint goods_products_pkey
            primary key,
    locale varchar(255) not null,
    product_subcategory_id integer,
    item_description text not null,
    brand varchar(255),
    item_size numeric(19,4),
    item_measure varchar(255),
    item_pack_name varchar(255),
    item_sell_quantity numeric(19,4),
    item_sell_pack_name varchar(255),
    concatenated_sell_unit varchar(255),
    concatenated_brand text,
    concatenated_description text,
    search_text text,
    lock_version integer default 0,
    created_at timestamp not null,
    updated_at timestamp not null,
    canonical_product_id integer,
    gs1_code varchar(255),
    category_id integer,
    replaced_at timestamp,
    volume_in_litres numeric(19,4),
    manufacturer_id integer,
    image_file_name varchar,
    image_content_type varchar,
    image_file_size integer,
    image_updated_at timestamp,
    brand_id integer,
    good_id integer,
    item_id integer,
    classic_product_mbid varchar,
    fmcg_code varchar,
    official_qualifier varchar,
    geo_qualifier varchar,
    specification_qualifier varchar,
    state_province varchar,
    region varchar,
    country_of_origin varchar,
    package_inner varchar,
    package_quantity_dimension_measure varchar,
    package_quantity_height_dimension numeric(19,4),
    package_quantity_width_dimension numeric(19,4),
    package_quantity_length_dimension numeric(19,4),
    package_quantity_weight_measure varchar,
    package_quantity_weight numeric(19,4),
    package_quantity numeric(19,4),
    average_weight_measure varchar,
    average_weight_quantity numeric(19,4),
    item_description_qualifier varchar,
    legacy_manufacturer_name varchar,
    manufacturer_code varchar,
    range_model varchar
);

create table if not exists goods_product_translations
(
    id serial not null
        constraint goods_product_translations_pkey
            primary key,
    product_id integer not null
        constraint fk_gpt_product
            references goods_products,
    locale varchar(255) not null,
    item_description text not null,
    brand varchar(255),
    item_size numeric(19,4),
    item_measure varchar(255),
    item_pack_name varchar(255),
    item_sell_quantity numeric(19,4),
    item_sell_pack_name varchar(255),
    range_model varchar(255),
    manufacturer_code varchar(255),
    legacy_manufacturer_name varchar(255),
    item_description_qualifier varchar(255),
    average_weight_quantity numeric(19,4),
    average_weight_measure varchar(255),
    package_quantity numeric(19,4),
    package_quantity_weight numeric(19,4),
    package_quantity_weight_measure varchar(255),
    package_quantity_length_dimension numeric(19,4),
    package_quantity_width_dimension numeric(19,4),
    package_quantity_height_dimension numeric(19,4),
    package_quantity_dimension_measure varchar(255),
    package_inner varchar(255),
    country_of_origin varchar(255),
    region varchar(255),
    state_province varchar(255),
    concatenated_sell_unit varchar(255),
    concatenated_brand text,
    concatenated_description text,
    search_text text,
    lock_version integer default 0,
    created_at timestamp not null,
    updated_at timestamp not null,
    specification_qualifier varchar(255),
    geo_qualifier varchar(255),
    official_qualifier varchar(255),
    gs1_code varchar(255),
    classic_product_mbid varchar(255)
);

create table if not exists goods_categories
(
    id serial not null
        constraint goods_categories_pkey
            primary key,
    name varchar(255),
    parent_id integer,
    created_at timestamp not null,
    updated_at timestamp not null,
    lock_version integer default 0,
    product_subcategory_id integer,
    path text,
    required_fields character varying[] default '{}'::character varying[],
    family_category_id integer
);

create table if not exists goods_category_hierarchies
(
    ancestor_id integer not null,
    descendant_id integer not null,
    generations integer not null
);

create table if not exists catalogues
(
    id serial not null
        constraint catalogues_pkey
            primary key,
    title varchar(255) not null,
    created_at timestamp not null,
    updated_at timestamp not null,
    owner_id integer not null,
    owner_type varchar(255) not null,
    catalogue_type varchar(255),
    is_master boolean default false,
    lock_version integer default 0,
    is_default boolean default false,
    category_customizable boolean,
    is_public boolean default false,
    is_deleted boolean default false,
    approval_workflow_id integer,
    search_text text,
    contracted boolean default false,
    catalogued_products_count integer default 0,
    version_name varchar(255),
    expired_at timestamp,
    predecessor_id integer,
    hidden boolean,
    purchaser_id integer,
    supplier_id integer,
    supplier_catalogue_id integer,
    path text,
    effective_date timestamp,
    expiry_date timestamp,
    account_id integer,
    account_path varchar(255),
    department_id integer,
    classic_instance varchar(255),
    custom_sorted boolean default false,
    destination_location_id integer,
    user_id integer
);

create table if not exists goods_catalogued_products
(
    id serial not null
        constraint goods_catalogued_products_pkey
            primary key,
    product_id integer not null
        constraint fk_gcp_product
            references goods_products,
    catalogue_id integer not null
        constraint fk_gcp_catalogue
            references catalogues,
    sell_unit_tax numeric(19,4),
    sell_unit_price numeric(19,4),
    sell_unit_tax_percentage numeric(19,4),
    lock_version integer default 0,
    created_at timestamp not null,
    updated_at timestamp not null,
    position integer,
    image_file_name varchar,
    image_content_type varchar,
    image_file_size bigint,
    image_updated_at timestamp,
    long_description text
);