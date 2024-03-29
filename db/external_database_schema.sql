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

create table invoice_line_items
(
    id serial not null
        constraint invoice_line_items_pkey
            primary key,
    ordered_price numeric(19,4) default 0,
    invoice_price numeric(19,4) default 0,
    total_invoiced_quantity numeric(19,4) default 0,
    quantity numeric(19,4) default 0,
    invoice_id integer not null,
    purchase_order_line_item_id integer,
    description varchar(1024),
    product_code varchar(255),
    purchase_order_line_item_created_at timestamp,
    locale varchar(255),
    lock_version integer default 0,
    created_at timestamp not null,
    updated_at timestamp not null,
    tax_amount numeric(19,4) default 0,
    tax_percentage numeric(19,4) default 0,
    line_total numeric(19,4) default 0,
    line_tax numeric(19,4) default 0,
    product_id integer,
    discount_total numeric(19,4) default 0,
    account_id integer,
    account_path text,
    department_id integer,
    flagged boolean default false,
    discount_tax numeric(19,4) default 0,
    reference text,
    membership text,
    adjustment_ex_tax numeric(19,4) default 0,
    adjustment_tax numeric(19,4) default 0,
    order_instruction text,
    product_brand text,
    product_description text,
    product_sell_unit varchar,
    product_item_size numeric(19,4),
    product_item_measure varchar,
    product_item_pack_name varchar,
    product_item_sell_quantity numeric(19,4),
    product_item_sell_pack_name varchar,
    product_gs1_code varchar,
    original_product_id integer,
    purchaser_party_product_id integer,
    supplier_party_product_id integer
);

create index idx_ili_by_purchase_order_line_item_id
    on invoice_line_items (purchase_order_line_item_id);

create index index_invli_by_invoice_id
    on invoice_line_items (invoice_id);

create index invli_product_id_idx
    on invoice_line_items (product_id);

create table trade_credit_note_lines
(
    id integer NOT NULL,
    credit_note_id integer NOT NULL,
    product_id integer NOT NULL,
    product_code character varying(255),
    description character varying(1024),
    account_id integer,
    account_path text,
    quantity numeric(19,4) DEFAULT 0,
    unit_price numeric(19,4) DEFAULT 0,
    tax_amount numeric(19,4) DEFAULT 0,
    tax_percentage numeric(19,4) DEFAULT 0,
    invoice_line_item_id integer,
    invoice_line_item_created_at timestamp without time zone,
    locale character varying(255),
    line_total numeric(19,4) DEFAULT 0,
    line_tax numeric(19,4) DEFAULT 0,
    discount_total numeric(19,4) DEFAULT 0,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    lock_version integer DEFAULT 0,
    department_id integer,
    discount_tax numeric(19,4) DEFAULT 0,
    reference text,
    membership text,
    adjustment_ex_tax numeric(19,4) DEFAULT 0,
    adjustment_tax numeric(19,4) DEFAULT 0,
    order_instruction text,
    product_brand text,
    product_description text,
    product_sell_unit character varying,
    product_item_size numeric(19,4),
    product_item_measure character varying,
    product_item_pack_name character varying,
    product_item_sell_quantity numeric(19,4),
    product_item_sell_pack_name character varying,
    product_gs1_code character varying
);

create index idx_tcni_by_account ON trade_credit_note_lines USING btree (account_id);
create index idx_tcni_by_credit_note ON trade_credit_note_lines USING btree (credit_note_id);
create index idx_tcni_by_product ON trade_credit_note_lines USING btree (product_id);

create table requisition_line_items
(
    id serial not null
        constraint requisition_line_items_pkey
            primary key,
    description varchar(1024),
    unit_price numeric(19,4) default 0,
    tax_amount numeric(19,4) default 0,
    quantity numeric(19,4) default 0,
    line_tax numeric(19,4) default 0,
    line_total numeric(19,4) default 0,
    created_at timestamp not null,
    updated_at timestamp not null,
    requisition_id integer not null,
    lock_version integer default 0,
    product_code varchar(255),
    locale varchar(255) default 'en'::character varying not null,
    vendor_id integer not null,
    tax_percentage numeric(19,4) default 0,
    line_price_premium numeric(19,4) default 0,
    highest_price_unit_price numeric(19,4) default 0,
    highest_price_unit_tax numeric(19,4) default 0,
    highest_price_supplier_id integer,
    lowest_price_unit_price numeric(19,4) default 0,
    lowest_price_unit_tax numeric(19,4) default 0,
    lowest_price_supplier_id integer,
    lowest_price_catalogue_id integer,
    highest_price_catalogue_id integer,
    expected_delivery_date date,
    delivery_address_id integer,
    product_id integer
        constraint fk_rli_product
            references goods_products,
    quotes integer,
    account_id integer,
    account_path text,
    department_id integer,
    highest_enabled_unit_price numeric(19,4),
    highest_enabled_unit_tax numeric(19,4),
    highest_enabled_supplier_id integer,
    lowest_enabled_unit_price numeric(19,4),
    lowest_enabled_unit_tax numeric(19,4),
    lowest_enabled_supplier_id integer,
    enabled_quotes integer,
    membership text,
    order_instruction text,
    contracted boolean,
    is_purchaser_price boolean,
    product_brand text,
    product_description text,
    product_sell_unit varchar,
    product_item_size numeric(19,4),
    product_item_measure varchar,
    product_item_pack_name varchar,
    product_item_sell_quantity numeric(19,4),
    product_item_sell_pack_name varchar,
    product_gs1_code varchar
);

create index idx_rli_by_requisition
    on requisition_line_items (requisition_id);

create index rqli_product_id_idx
    on requisition_line_items (product_id);

create table inventory_internal_requisition_lines
(
    id serial not null
        constraint inventory_internal_requisition_lines_pkey
            primary key,
    product_id integer not null,
    internal_requisition_id integer not null,
    description text,
    search_text text,
    unit_price numeric(19,4),
    quantity numeric(19,4),
    available_quantity numeric(19,4),
    total numeric(19,4),
    locale varchar,
    count_units boolean,
    created_at timestamp,
    updated_at timestamp,
    lock_version integer,
    product_brand text,
    product_description text,
    product_sell_unit varchar,
    product_item_size numeric(19,4),
    product_item_measure varchar,
    product_item_pack_name varchar,
    product_item_sell_quantity numeric(19,4),
    product_item_sell_pack_name varchar,
    product_gs1_code varchar
);

create index idx_iirl_on_nternal_requisition_id
    on inventory_internal_requisition_lines (internal_requisition_id);

create index index_inventory_internal_requisition_lines_on_product_id
    on inventory_internal_requisition_lines (product_id);


create table purchase_order_line_items
(
    id serial not null
        constraint purchase_order_line_items_pkey
            primary key,
    description varchar(1024),
    unit_price numeric(19,4) default 0,
    tax_amount numeric(19,4) default 0,
    quantity numeric(19,4) default 0,
    line_tax numeric(19,4) default 0,
    line_total numeric(19,4) default 0,
    created_at timestamp not null,
    updated_at timestamp not null,
    purchase_order_id integer not null,
    lock_version integer default 0,
    product_code varchar(255),
    requisition_line_item_created_at timestamp,
    locale varchar(255) default 'en'::character varying,
    tax_percentage numeric(19,4) default 0,
    requisition_line_item_id integer
        constraint fk_po_line_items_req_line_items
            references requisition_line_items,
    expected_delivery_date date,
    delivery_address_id integer,
    organisation_product_id integer,
    product_id integer
        constraint fk_poli_product
            references goods_products,
    procurement_product_id integer,
    discount_total numeric(19,4) default 0,
    account_id integer,
    account_path text,
    department_id integer,
    origin_id integer,
    origin_type varchar(255),
    predecessor_id integer,
    membership text,
    parent_id integer,
    order_instruction text,
    is_purchaser_price boolean,
    product_brand text,
    product_description text,
    product_sell_unit varchar,
    product_item_size numeric(19,4),
    product_item_measure varchar,
    product_item_pack_name varchar,
    product_item_sell_quantity numeric(19,4),
    product_item_sell_pack_name varchar,
    product_gs1_code varchar
);

create index idx_poli_by_purchase_order
    on purchase_order_line_items (purchase_order_id);

create index index_poli_by_rli_id
    on purchase_order_line_items (requisition_line_item_id);

create index index_purchase_order_line_items_on_parent_id
    on purchase_order_line_items (parent_id);

create index index_purchase_order_line_items_on_updated_at
    on purchase_order_line_items (updated_at);

create index poli_product_id_idx
    on purchase_order_line_items (product_id);

create table receiving_document_line_items
(
    id serial not null
        constraint receiving_document_line_items_pkey
            primary key,
    extended_price numeric(19,4) default 0,
    quantity numeric(19,4) default 0,
    receiving_document_id integer not null,
    purchase_order_line_item_id integer
        constraint fk_receiving_document_line_items_purchase_order_line_item
            references purchase_order_line_items,
    created_at timestamp not null,
    updated_at timestamp not null,
    product_code varchar(255),
    purchase_order_line_item_created_at timestamp,
    locale varchar(255),
    lock_version integer default 0,
    description varchar(1024),
    product_id integer
        constraint fk_rdli_product
            references goods_products,
    location_id integer,
    unit_value numeric(19,4) default 0,
    order_instruction text,
    product_brand text,
    product_description text,
    product_sell_unit varchar,
    product_item_size numeric(19,4),
    product_item_measure varchar,
    product_item_pack_name varchar,
    product_item_sell_quantity numeric(19,4),
    product_item_sell_pack_name varchar,
    product_gs1_code varchar,
    linked_to_product_id integer,
    linked_to_always boolean default true,
    temperature varchar,
    comment text,
    vehicle_temperature varchar,
    exp_date date,
    produced_date date,
    override_unit_value numeric
);

create index idx_rdli_by_purchase_order_line_item_id
    on receiving_document_line_items (purchase_order_line_item_id);

create index index_rdli_by_rd_id
    on receiving_document_line_items (receiving_document_id);

create index rdli_product_id_idx
    on receiving_document_line_items (product_id);

create table point_of_sale_lines
(
    id serial not null
        constraint point_of_sale_lines_pkey
            primary key,
    product_id integer not null
        constraint fk_posl_product
            references goods_products,
    outlet_code varchar,
    transaction_date date,
    plu_code varchar,
    plu_description text,
    quantity numeric(19,4) not null,
    cost_unit_price numeric(19,4) default 0.0,
    cost_unit_tax numeric(19,4) default 0.0,
    cost_tax numeric(19,4) default 0.0,
    cost_total_ex_tax numeric(19,4) default 0.0,
    sell_unit_price numeric(19,4) default 0.0,
    sell_unit_tax numeric(19,4) default 0.0,
    sell_unit_tax_percentage numeric(19,4) default 0.0,
    sell_tax numeric(19,4) default 0.0,
    sell_total_ex_tax numeric(19,4) default 0.0,
    search_text text,
    created_at timestamp,
    updated_at timestamp,
    sale_id integer,
    state varchar,
    error_messages text,
    outlet_id integer,
    preparation_cost numeric(19,4) default 0,
    family_code varchar,
    check_number varchar
);

create index idx_posl_product
    on point_of_sale_lines (product_id);

create table inventory_transfer_items
(
    id serial not null
        constraint inventory_transfer_items_pkey
            primary key,
    transfer_id integer not null,
    origin_id integer,
    destination_id integer,
    product_id integer not null
        constraint fk_transfer_item_product
            references goods_products,
    quantity numeric(19,4),
    value numeric(19,4),
    comments_count integer default 0,
    lock_version integer default 0,
    created_at timestamp,
    updated_at timestamp,
    unit_value numeric(19,4),
    count_units boolean,
    predecessor_type varchar(255),
    predecessor_id integer,
    creator_id integer,
    updator_id integer,
    destination_account_id integer,
    destination_account_path text,
    destination_product_id integer
);

create index idx_iti_on_updated_at
    on inventory_transfer_items (updated_at);

create index index_inventory_transfer_items_on_destination_id
    on inventory_transfer_items (destination_id);

create index index_inventory_transfer_items_on_origin_id
    on inventory_transfer_items (origin_id);

create index index_inventory_transfer_items_on_transfer_id
    on inventory_transfer_items (transfer_id);

create index index_inventory_transfer_items_on_product_id
    on inventory_transfer_items (product_id);

create table inventory_barcodes
(
    id serial not null
        constraint inventory_barcodes_pkey
            primary key,
    product_id integer not null
        constraint fk_ib_products
            references goods_products,
    holder_id integer not null,
    body varchar not null,
    is_deleted boolean,
    created_at timestamp,
    updated_at timestamp,
    is_default boolean,
    search_text text
);

create unique index index_inventory_barcodes_on_body_holder
    on inventory_barcodes (body, holder_id);

create index index_inventory_barcodes_on_holder_id
    on inventory_barcodes (holder_id);

create index index_inventory_barcodes_on_product_id
    on inventory_barcodes (product_id);

create table inventory_derived_period_balances
(
    id serial not null
        constraint inventory_derived_period_balances_pkey
            primary key,
    location_id integer not null,
    stock_level_id integer,
    product_id integer not null
        constraint fk_derived_balances_product
            references goods_products,
    period date,
    balance_quantity numeric(19,4),
    balance_value numeric(19,4),
    is_deleted boolean default false
);

create index idx_idpb_on_stock_level_id
    on inventory_derived_period_balances (stock_level_id);

create index index_inventory_derived_period_balances_on_period
    on inventory_derived_period_balances (period);

create index index_inventory_derived_period_balances_on_product_id
    on inventory_derived_period_balances (product_id);

create table inventory_stock_counts
(
    id serial not null
        constraint inventory_stock_counts_pkey
            primary key,
    stock_take_id integer not null,
    stock_level_id integer,
    quantity numeric(19,4),
    lock_version integer default 0,
    created_at timestamp,
    updated_at timestamp,
    expected_quantity numeric(19,4),
    variance numeric(19,4),
    count_units boolean,
    creator_id integer,
    updator_id integer,
    opening_quantity numeric(19,4),
    product_id integer not null
        constraint fk_count_product
            references goods_products,
    unit_value numeric(19,4)
);

alter table inventory_stock_counts owner to postgres;

create index index_inventory_stock_counts_on_product_id
    on inventory_stock_counts (product_id);

create index index_inventory_stock_counts_on_stock_level_id
    on inventory_stock_counts (stock_level_id);

create index index_inventory_stock_counts_on_stock_take_id
    on inventory_stock_counts (stock_take_id);

create table inventory_stock_levels
(
    id serial not null
        constraint inventory_stock_levels_pkey
            primary key,
    location_id integer not null,
    product_id integer not null
        constraint fk_level_product
            references goods_products,
    balance_quantity numeric(19,4) default 0.0,
    balance_value numeric(19,4) default 0.0,
    par_level numeric(19,4) default 0.0,
    reorder_level numeric(19,4) default 0.0,
    base_quantity numeric(19,4) default 0.0,
    base_value numeric(19,4) default 0.0,
    baselined_at timestamp,
    lock_version integer default 0,
    created_at timestamp,
    updated_at timestamp,
    unit_value numeric(19,4),
    count_units boolean,
    position integer,
    is_deleted boolean default false,
    linked_to_id integer,
    sale_price numeric
);

create index index_inventory_stock_levels_on_location_id
    on inventory_stock_levels (location_id);

create index index_inventory_stock_levels_on_product_id
    on inventory_stock_levels (product_id);

create table procurement_products
(
    id serial not null
        constraint procurement_products_pkey
            primary key,
    product_id integer not null
        constraint fk_pp_product
            references goods_products,
    organisation_id integer not null,
    code varchar(255),
    last_purchase_sell_unit_price numeric(19,4),
    last_purchase_sell_unit_tax numeric(19,4),
    last_supplier_id integer,
    state integer,
    linked_to_id integer
        constraint fk_linked_to_product
            references goods_products,
    purchase_order_line_items_count integer default 0,
    created_at timestamp not null,
    updated_at timestamp not null,
    last_purchased_at timestamp,
    linker_user_id integer,
    market_price numeric(19,4),
    brand varchar(255),
    range_model varchar(255),
    item_description text,
    package_inner varchar(255),
    gs1_code varchar(255),
    item_size numeric(19,4),
    item_measure varchar(255),
    item_pack_name varchar(255),
    item_sell_quantity integer,
    item_sell_pack_name varchar(255),
    package_code varchar(255),
    locale varchar(255),
    category_description varchar(255),
    subcategory_description varchar(255),
    plu_code varchar,
    last_instrumented_at timestamp,
    last_sold_at timestamp,
    last_purchaser_id integer,
    invoice_line_items_count integer,
    inventory_link_organisation_wide boolean default false
);

create index idx_op_plu_code
    on procurement_products (plu_code);

create index idx_pp_by_org_and_code
    on procurement_products (organisation_id, code);

create unique index idx_procp_on_org_id_prod_id
    on procurement_products (organisation_id, product_id);

create index idx_procp_on_organisation_id
    on procurement_products (organisation_id);

create index idx_procp_on_product_id
    on procurement_products (product_id);

create index idx_trgm_pp_by_code
    on procurement_products (code);

create index index_procurement_products_on_updated_at
    on procurement_products (updated_at);

create table product_supplier_preferences
(
    id serial not null
        constraint product_supplier_preferences_pkey
            primary key,
    product_id integer not null
        constraint fk_psp_products
            references goods_products,
    purchaser_id integer not null,
    supplier_id integer not null,
    enabled boolean default true not null,
    lock_version integer default 0,
    created_at timestamp not null,
    updated_at timestamp not null
);

create index idx_psp_by_product
    on product_supplier_preferences (product_id);

create unique index idx_psp_by_product_trade
    on product_supplier_preferences (product_id, purchaser_id, supplier_id);

create index idx_psp_by_purchaser
    on product_supplier_preferences (purchaser_id);

create index idx_psp_by_supplier
    on product_supplier_preferences (supplier_id);

create table rebates_profile_products
(
    id serial not null
        constraint rebates_profile_products_pkey
            primary key,
    profile_id integer,
    product_id integer,
    created_at timestamp,
    updated_at timestamp
);

create index index_rebates_profile_products_on_product_id
    on rebates_profile_products (product_id);

create index index_rebates_profile_products_on_profile_id
    on rebates_profile_products (profile_id);

create table recipes
(
    id serial not null
        constraint recipes_pkey
            primary key,
    name varchar(255) not null,
    owner_id integer not null,
    code varchar(255),
    actual_retail_price numeric(19,4),
    live_cost_price numeric(19,4),
    cost_percentage numeric(19,4),
    created_at timestamp not null,
    updated_at timestamp not null,
    recipe_menu_id integer,
    course text,
    size numeric(19,4),
    measure varchar(255),
    search_text text,
    suggested_sell_price numeric(19,4),
    live_cost_tax numeric(19,4),
    serving_size numeric(19,4),
    serving_measure varchar(255),
    serving_cost numeric(19,4),
    serving_cost_tax numeric(19,4),
    serving_actual_retail_price numeric(19,4),
    serving_cost_percent numeric(19,4),
    last_costing_date timestamp,
    preparation_method text,
    service_staff_info text,
    image_url varchar(255),
    reference_web_url varchar(255),
    owned_by_user varchar(255),
    image_file_name varchar(255),
    image_content_type varchar(255),
    image_file_size integer,
    image_updated_at timestamp,
    presentation text,
    last_calculated_at timestamp,
    is_recalculating boolean default false,
    product_id integer
        constraint fk_recipes_product
            references goods_products,
    pre_make boolean default false,
    account_id integer,
    account_path text
);

create index idx_by_owner_and_name
    on recipes (owner_id, name);

create index idx_recipes_by_product
    on recipes (product_id);

create index idx_trgm_rcp_by_search_text
    on recipes (search_text);

create table organisations
(
    id serial not null
        constraint organisations_pkey
            primary key,
    telephone varchar(255),
    fax varchar(255),
    email varchar(255),
    postal_address_postal_code varchar(255),
    postal_address_country varchar(255),
    billing_address_is_postal_address boolean,
    billing_address_postal_code varchar(255),
    billing_address_country varchar(255),
    is_a_purchaser boolean,
    is_a_supplier boolean,
    is_a_administrator boolean,
    created_at timestamp not null,
    updated_at timestamp not null,
    default_delivery_address_id integer,
    is_verified boolean,
    lock_version integer default 0,
    default_language varchar(255) default 'en'::character varying,
    owner_id integer,
    time_zone varchar(255) default 'UTC'::character varying,
    is_deleted boolean,
    website_url varchar(255),
    business_number varchar(255),
    logo_file_name varchar(255),
    logo_content_type varchar(255),
    logo_file_size integer,
    description text,
    short_description varchar(255),
    accounts_email varchar(255),
    is_billable boolean default false,
    title varchar(255),
    name varchar(255),
    is_inventory_enabled boolean,
    postal_address_line1 varchar(255),
    postal_address_line2 varchar(255),
    postal_address_city varchar(255),
    postal_address_state_province varchar(255),
    billing_address_line1 varchar(255),
    billing_address_line2 varchar(255),
    billing_address_city varchar(255),
    billing_address_state_province varchar(255),
    locale varchar(255) default 'en'::character varying,
    search_text text,
    receive_only_from_master_catalogue boolean default false,
    delivery_instructions text,
    confirmation_instructions text,
    signature_image_file_name varchar(255),
    signature_image_content_type varchar(255),
    signature_image_file_size integer,
    signature_image_updated_at timestamp,
    auto_close_order boolean default false,
    parent_id integer,
    region_id integer,
    three_way_match_enabled boolean default true,
    allow_negative_stock_level boolean default true,
    accounts_payable_system_id integer,
    access_group_id integer,
    enforce_password_change boolean default false,
    department_code varchar(255),
    invoice_method varchar(255),
    discount_rate numeric(19,4) default 0,
    legal_entity boolean default false,
    weekly_payment boolean default false,
    path text,
    default_account_id integer,
    accepted_invoicing_terms boolean,
    business_unit varchar(255),
    requisition_approval_workflow_id integer,
    iana_time_zone varchar(255),
    canonical_id integer,
    concatenate_product_and_pack_codes boolean default false,
    show_membership boolean default false,
    outlet_code varchar,
    purchase_order_reply_to_email varchar,
    print_format_file_name varchar,
    print_format_content_type varchar,
    print_format_file_size integer,
    preferred_supplier_only boolean default false,
    terms_and_conditions text,
    point_of_sale_import_format_id integer,
    continuous_approving boolean default false,
    corporate_code text,
    punchout_line_transformer_type varchar,
    location_id integer,
    accepts_electronic_invoices boolean default false,
    zuora_account_id varchar,
    email_api_invoice_copy boolean default false,
    room_count integer,
    page_size_limit integer default 25,
    zuora_category varchar,
    billing_email varchar,
    invoice_template_id integer,
    billing_agreement_file_name varchar,
    billing_agreement_content_type varchar,
    billing_agreement_file_size integer,
    billing_agreement_customised boolean,
    xtracta_id integer,
    invoice_days_threshold integer,
    company_brand varchar,
    requires_budget_approval boolean default false,
    autopopulate_par_level boolean default false,
    business_name varchar,
    document_validation_threshold numeric(19,4),
    document_line_validation_threshold numeric(19,4),
    whatfix_enabled boolean default false,
    api_url varchar,
    api_username varchar,
    api_password varchar,
    api_token varchar,
    api_invoice_polling_interval_minutes integer,
    api_provider varchar,
    api_last_polled_at timestamp,
    billing_currency varchar,
    purchase_order_copy_email text,
    mandatory_informal_product_tax boolean default false,
    mandatory_informal_product_tax_percentage numeric(19,4),
    ppi_access boolean default false,
    is_capex boolean default false,
    auto_recalculate_recipe_cost boolean default false,
    display_xtracta_detail boolean default false,
    default_app varchar default 'p+'::character varying,
    pplus_access boolean default true,
    ppx_access boolean default false,
    credit_application_url varchar,
    destination_company_code varchar,
    origin_company_code varchar,
    live_chat_enabled boolean default true,
    minimum_order_value numeric,
    minimum_order_value_message varchar,
    supplier_agreement_signed_at date,
    supplier_subscription_tier varchar default 'non_member'::character varying,
    input_tax boolean default false,
    ppnew_access boolean default false
);

create index idx_o_by_default_delivery_address
    on organisations (default_delivery_address_id);

create index idx_organisations_by_outlet_code
    on organisations (outlet_code);

create index idx_trgm_org_by_search_text
    on organisations (search_text);

create index index_organisations_on_location_id
    on organisations (location_id);

create index index_organisations_on_parent_id
    on organisations (parent_id);

create index index_organisations_on_zuora_account_id
    on organisations (zuora_account_id);

create view vw_product_transaction_usage_counts(id, invoice_line_items_count, credit_note_lines_count, requisition_line_items_count, purchase_order_line_items_count,
                                                receiving_document_line_items_count, inventory_internal_requisition_lines_count, inventory_transfer_items_count, inventory_stock_counts_count,
                                                point_of_sale_lines_count) as
SELECT gp.id,
       (SELECT count(invoice_line_items.id) AS count
        FROM invoice_line_items
        WHERE invoice_line_items.product_id = gp.id)                   AS invoice_line_items_count,
       (SELECT count(trade_credit_note_lines.id) AS count
        FROM trade_credit_note_lines
        WHERE trade_credit_note_lines.product_id = gp.id)              AS credit_note_lines_count,
       (SELECT count(requisition_line_items.id) AS count
        FROM requisition_line_items
        WHERE requisition_line_items.product_id = gp.id)               AS requisition_line_items_count,
       (SELECT count(inventory_internal_requisition_lines.id) AS count
        FROM inventory_internal_requisition_lines
        WHERE inventory_internal_requisition_lines.product_id = gp.id) AS inventory_internal_requisition_lines_count,
       (SELECT count(purchase_order_line_items.id) AS count
        FROM purchase_order_line_items
        WHERE purchase_order_line_items.product_id = gp.id)            AS purchase_order_line_items_count,
       (SELECT count(receiving_document_line_items.id) AS count
        FROM receiving_document_line_items
        WHERE receiving_document_line_items.product_id = gp.id)        AS receiving_document_line_items_count,
       (SELECT count(point_of_sale_lines.id) AS count
        FROM point_of_sale_lines
        WHERE point_of_sale_lines.product_id = gp.id)                  AS point_of_sale_lines_count,
       (SELECT count(inventory_transfer_items.id) AS count
        FROM inventory_transfer_items
        WHERE inventory_transfer_items.product_id = gp.id)             AS inventory_transfer_items_count,
       (SELECT count(inventory_stock_counts.id) AS count
        FROM inventory_stock_counts
        WHERE inventory_stock_counts.product_id = gp.id)               AS inventory_stock_counts_count
FROM goods_products gp
         JOIN goods_catalogued_products gcp ON gcp.product_id = gp.id AND gcp.catalogue_id = 1;

create view vw_product_catalogue_usage_counts(id, catalogue_count, buy_list_count, priced_catalogue_count, recipes_count,
                                              inventory_stock_levels_count, inventory_derived_period_balances_count) as
SELECT gp.id,
       (SELECT count(cp.id) AS count
        FROM goods_catalogued_products cp
        WHERE cp.product_id = gp.id AND cp.catalogue_id != 1)          AS catalogue_count,
       (SELECT count(cp.id) AS count
        FROM goods_catalogued_products cp
                 JOIN catalogues c ON c.id = cp.catalogue_id AND c.catalogue_type::text = 'Product'::text AND cp.catalogue_id != 1
        WHERE cp.product_id = gp.id)                                   AS buy_list_count,
       (SELECT count(cp.id) AS count
        FROM goods_catalogued_products cp
                 JOIN catalogues c ON c.id = cp.catalogue_id AND c.catalogue_type::text = 'Priced'::text AND cp.catalogue_id != 1
        WHERE cp.product_id = gp.id)                                   AS priced_catalogue_count,
       (SELECT count(inventory_derived_period_balances.id) AS count
        FROM inventory_derived_period_balances
        WHERE inventory_derived_period_balances.product_id = gp.id)    AS inventory_derived_period_balances_count,
       (SELECT count(inventory_stock_levels.id) AS count
        FROM inventory_stock_levels
        WHERE inventory_stock_levels.product_id = gp.id)               AS inventory_stock_levels_count,
       (SELECT count(recipes.id) AS count
        FROM recipes
        WHERE recipes.product_id = gp.id)                              AS recipes_count
FROM goods_products gp
         JOIN goods_catalogued_products gcp ON gcp.product_id = gp.id AND gcp.catalogue_id = 1;

create view vw_product_settings_usage_counts(id, inventory_barcodes_count, procurement_products_count, product_supplier_preferences_count,
                                             rebates_profile_products_count, linked_products_count) as
SELECT gp.id,
       (SELECT count(inventory_barcodes.id) AS count
        FROM inventory_barcodes
        WHERE inventory_barcodes.product_id = gp.id)                   AS inventory_barcodes_count,
       (SELECT count(procurement_products.id) AS count
        FROM procurement_products
        WHERE procurement_products.product_id = gp.id)                 AS procurement_products_count,
       (SELECT count(procurement_products.linked_to_id) AS count
        FROM procurement_products
        WHERE procurement_products.linked_to_id = gp.id)               AS linked_products_count,
       (SELECT count(product_supplier_preferences.id) AS count
        FROM product_supplier_preferences
        WHERE product_supplier_preferences.product_id = gp.id)         AS product_supplier_preferences_count,
       (SELECT count(rebates_profile_products.id) AS count
        FROM rebates_profile_products
        WHERE rebates_profile_products.product_id = gp.id)             AS rebates_profile_products_count
FROM goods_products gp
         JOIN goods_catalogued_products gcp ON gcp.product_id = gp.id AND gcp.catalogue_id = 1;

CREATE VIEW vw_product_pricing_statistics(id, price_count, minimum_price, maximum_price, average_price, median_price,
    standard_deviation, catalogue_owner_country) AS
SELECT gp.id,
       COUNT(gcp.id) AS price_count,
       MIN(sell_unit_price) AS minimum_price,
       MAX(sell_unit_price) AS maximum_price,
       AVG(sell_unit_price) AS average_price,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sell_unit_price) AS median_price,
       STDDEV_POP(sell_unit_price) AS standard_deviation,
       s.postal_address_country AS catalogue_owner_country
FROM goods_products gp
         INNER JOIN goods_catalogued_products gcp ON gcp.product_id = gp.id
         INNER JOIN catalogues c ON c.id = gcp.catalogue_id
         INNER JOIN organisations s ON s.id = c.owner_id
WHERE gcp.sell_unit_price != 0 AND gp.id IN (SELECT p.id FROM goods_products p INNER JOIN goods_catalogued_products cp ON cp.product_id = p.id AND cp.catalogue_id = 1)
GROUP BY gp.id, s.postal_address_country

