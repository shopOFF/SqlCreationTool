drop table df_qbe_homebusinesss purge;

create table df_qbe_homebusinesss (
    object_id                         number constraint df_qbe_homebusiness_nn not null,
    unabletocomplete                  varchar2(100),
    unabletocompletereason            varchar2(1000),
    businessdesc                      varchar2(1000),
    businesslocation                  varchar2(100),
    businesshours                     varchar2(200),
    customersonsite                   varchar2(100),
    merchandiseforsale                varchar2(100),
    merchandisedesc                   varchar2(1000),
    insureditemssold                  varchar2(100),
    insureditemssolddesc              varchar2(1000),
    inventoryplace                    varchar2(1000),
    inventorynumber                   varchar2(1000),
    chemicalsonsite                   varchar2(100),
    chemicalsonsitedesc               varchar2(1000),
    itemsplace                        varchar2(1000),
    specialequipment                  varchar2(100),
    specialequipmentdesc              varchar2(1000),
    housekeepingissues                varchar2(100),
    housekeepingissuesdesc            varchar2(1000),
    deckporchcondition                varchar2(100),
    deckporchconditiondesc            varchar2(1000),
    animals                           varchar2(100),
    animalsdesc                       varchar2(1000),
    employees                         varchar2(100),
    employeesfulltime                 varchar2(200),
    employeesparttime                 varchar2(200),
    businessfood                      varchar2(100),
    commercialappliances              varchar2(100),
    commercialappliancesdesc          varchar2(1000),
    sprinklersystem                   varchar2(100),
    sprinklersystemdesc               varchar2(1000),
    ingredientslabeled                varchar2(100),
    ingredientslabeleddesc            varchar2(1000),
    foodareanotclean                  varchar2(100),
    foodareanotcleandesc              varchar2(1000),
    constraint df_qbe_homebusiness_pk primary key (object_id),
    constraint df_qbe_homebusiness_fk foreign key (object_id) references acs_objects(object_id)
);

begin
    acs_object_type.drop_type ('df_qbe_homebusiness','t');
    acs_object_type.create_type (
            object_type => 'df_qbe_homebusiness',
            pretty_name => 'Home Business',
            pretty_plural => 'Home Business',
            supertype => 'form_abstract',
            table_name => 'df_qbe_homebusinesss',
            id_column => 'object_id',
            package_name => 'df_qbe_homebusiness',
            abstract_p => 'f',
            type_extension_table => '',
            name_method => '',
            dynamic_p => 'f',
            getxml_p => 'f'
    );
end;
/
show errors;


declare
    v_attribute_id     number;
    v_enum_id          number;
    v_hazard_rule_id   number;
    v_company_id       number;
    v_creator_id       number;
    v_result           varchar2(100);
begin
    select object_id into v_company_id from site_nodes where surl = '/EMI/QBE/';

    select party_id into v_creator_id from parties where email = 'admin@myriad-development.com';
    v_hazard_rule_id := hazard_rule.new(i_company_id => v_company_id, i_description => 'Initial', i_effective_date => sysdate, i_creator_id => v_creator_id, i_hzd_weight_threshold => 11, i_hzd_count_threshold => 0);
    delete from rules_hazard_attributes where hazard_rule_id = v_hazard_rule_id and attribute_id not in (select attribute_id from acs_attributes);


    -- ***************************************************
    -- unabletocomplete

    acs_attribute.drop_attribute ('df_qbe_homebusiness','unabletocomplete');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'unabletocomplete',
        datatype => 'enumeration',
        pretty_name => 'Unable to complete',
        pretty_plural => 'Unable to complete',
        default_value => '',
        sort_order => 10,
        table_name => '',
        column_name => 'unabletocomplete',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- unabletocompletereason

    acs_attribute.drop_attribute ('df_qbe_homebusiness','unabletocompletereason');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'unabletocompletereason',
        datatype => 'explain',
        pretty_name => 'Reason Unable to complete',
        pretty_plural => 'Reason Unable to complete',
        default_value => '',
        sort_order => 20,
        table_name => '',
        column_name => 'unabletocompletereason',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- businessdesc

    acs_attribute.drop_attribute ('df_qbe_homebusiness','businessdesc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'businessdesc',
        datatype => 'explain',
        pretty_name => 'Description of Business',
        pretty_plural => 'Description of Business',
        default_value => '',
        sort_order => 30,
        table_name => '',
        column_name => 'businessdesc',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- businesslocation

    acs_attribute.drop_attribute ('df_qbe_homebusiness','businesslocation');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'businesslocation',
        datatype => 'enumeration',
        pretty_name => 'Location of Business (provide photos)',
        pretty_plural => 'Location of Business (provide photos)',
        default_value => '',
        sort_order => 40,
        table_name => '',
        column_name => 'businesslocation',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'IN_DWL', 'In dwelling', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'IN_DWL', 'In dwelling', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'OUT_BLD', 'Outbuilding', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'OUT_BLD', 'Outbuilding', 20, 't', '', '', v_enum_id);

    -- ***************************************************
    -- businesshours

    acs_attribute.drop_attribute ('df_qbe_homebusiness','businesshours');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'businesshours',
        datatype => 'number',
        pretty_name => 'How many hours a week is business open?',
        pretty_plural => 'How many hours a week is business open?',
        default_value => '',
        sort_order => 50,
        table_name => '',
        column_name => 'businesshours',
        min_n_values => 1,
        max_n_values => 200
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- customersonsite

    acs_attribute.drop_attribute ('df_qbe_homebusiness','customersonsite');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'customersonsite',
        datatype => 'enumeration',
        pretty_name => 'Do customers come on site?',
        pretty_plural => 'Do customers come on site?',
        default_value => '',
        sort_order => 60,
        table_name => '',
        column_name => 'customersonsite',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- merchandiseforsale

    acs_attribute.drop_attribute ('df_qbe_homebusiness','merchandiseforsale');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'merchandiseforsale',
        datatype => 'enumeration',
        pretty_name => 'Is merchandise for sale on site',
        pretty_plural => 'Is merchandise for sale on site',
        default_value => '',
        sort_order => 70,
        table_name => '',
        column_name => 'merchandiseforsale',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- ***************************************************
    -- merchandisedesc

    acs_attribute.drop_attribute ('df_qbe_homebusiness','merchandisedesc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'merchandisedesc',
        datatype => 'explain',
        pretty_name => 'Describe merchandise/inventory on premises',
        pretty_plural => 'Describe merchandise/inventory on premises',
        default_value => '',
        sort_order => 80,
        table_name => '',
        column_name => 'merchandisedesc',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- insureditemssold

    acs_attribute.drop_attribute ('df_qbe_homebusiness','insureditemssold');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'insureditemssold',
        datatype => 'enumeration',
        pretty_name => 'Does insured make items sold?',
        pretty_plural => 'Does insured make items sold?',
        default_value => '',
        sort_order => 90,
        table_name => '',
        column_name => 'insureditemssold',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- ***************************************************
    -- insureditemssolddesc

    acs_attribute.drop_attribute ('df_qbe_homebusiness','insureditemssolddesc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'insureditemssolddesc',
        datatype => 'explain',
        pretty_name => 'If so, Describe',
        pretty_plural => 'If so, Describe',
        default_value => '',
        sort_order => 100,
        table_name => '',
        column_name => 'insureditemssolddesc',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- inventoryplace

    acs_attribute.drop_attribute ('df_qbe_homebusiness','inventoryplace');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'inventoryplace',
        datatype => 'explain',
        pretty_name => 'Where is inventory/supplies stored',
        pretty_plural => 'Where is inventory/supplies stored',
        default_value => '',
        sort_order => 110,
        table_name => '',
        column_name => 'inventoryplace',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- inventorynumber

    acs_attribute.drop_attribute ('df_qbe_homebusiness','inventorynumber');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'inventorynumber',
        datatype => 'explain',
        pretty_name => 'How much inventory on site',
        pretty_plural => 'How much inventory on site',
        default_value => '',
        sort_order => 120,
        table_name => '',
        column_name => 'inventorynumber',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- chemicalsonsite

    acs_attribute.drop_attribute ('df_qbe_homebusiness','chemicalsonsite');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'chemicalsonsite',
        datatype => 'enumeration',
        pretty_name => 'Any flammable or hazardous  chemicals kept on site',
        pretty_plural => 'Any flammable or hazardous  chemicals kept on site',
        default_value => '',
        sort_order => 130,
        table_name => '',
        column_name => 'chemicalsonsite',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- chemicalsonsitedesc

    acs_attribute.drop_attribute ('df_qbe_homebusiness','chemicalsonsitedesc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'chemicalsonsitedesc',
        datatype => 'explain',
        pretty_name => 'Describe',
        pretty_plural => 'Describe',
        default_value => '',
        sort_order => 140,
        table_name => '',
        column_name => 'chemicalsonsitedesc',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- itemsplace

    acs_attribute.drop_attribute ('df_qbe_homebusiness','itemsplace');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'itemsplace',
        datatype => 'explain',
        pretty_name => 'Where are items stored?',
        pretty_plural => 'Where are items stored?',
        default_value => '',
        sort_order => 150,
        table_name => '',
        column_name => 'itemsplace',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- specialequipment

    acs_attribute.drop_attribute ('df_qbe_homebusiness','specialequipment');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'specialequipment',
        datatype => 'enumeration',
        pretty_name => 'Any special equipment in the business',
        pretty_plural => 'Any special equipment in the business',
        default_value => '',
        sort_order => 160,
        table_name => '',
        column_name => 'specialequipment',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- specialequipmentdesc

    acs_attribute.drop_attribute ('df_qbe_homebusiness','specialequipmentdesc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'specialequipmentdesc',
        datatype => 'explain',
        pretty_name => 'Describe',
        pretty_plural => 'Describe',
        default_value => '',
        sort_order => 170,
        table_name => '',
        column_name => 'specialequipmentdesc',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- housekeepingissues

    acs_attribute.drop_attribute ('df_qbe_homebusiness','housekeepingissues');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'housekeepingissues',
        datatype => 'enumeration',
        pretty_name => 'Are there any houskeeping issues. (Is area cluttered, walkways not clear, any obvious property and liability issues)',
        pretty_plural => 'Are there any houskeeping issues. (Is area cluttered, walkways not clear, any obvious property and liability issues)',
        default_value => '',
        sort_order => 180,
        table_name => '',
        column_name => 'housekeepingissues',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- housekeepingissuesdesc

    acs_attribute.drop_attribute ('df_qbe_homebusiness','housekeepingissuesdesc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'housekeepingissuesdesc',
        datatype => 'explain',
        pretty_name => 'Describe',
        pretty_plural => 'Describe',
        default_value => '',
        sort_order => 190,
        table_name => '',
        column_name => 'housekeepingissuesdesc',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- deckporchcondition

    acs_attribute.drop_attribute ('df_qbe_homebusiness','deckporchcondition');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'deckporchcondition',
        datatype => 'enumeration',
        pretty_name => 'Are stairways, decks and porches not railed or in poor condition?',
        pretty_plural => 'Are stairways, decks and porches not railed or in poor condition?',
        default_value => '',
        sort_order => 200,
        table_name => '',
        column_name => 'deckporchcondition',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- deckporchconditiondesc

    acs_attribute.drop_attribute ('df_qbe_homebusiness','deckporchconditiondesc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'deckporchconditiondesc',
        datatype => 'explain',
        pretty_name => 'Describe',
        pretty_plural => 'Describe',
        default_value => '',
        sort_order => 210,
        table_name => '',
        column_name => 'deckporchconditiondesc',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- animals

    acs_attribute.drop_attribute ('df_qbe_homebusiness','animals');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'animals',
        datatype => 'enumeration',
        pretty_name => 'Any animals on the property and in contact with general public?',
        pretty_plural => 'Any animals on the property and in contact with general public?',
        default_value => '',
        sort_order => 220,
        table_name => '',
        column_name => 'animals',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- animalsdesc

    acs_attribute.drop_attribute ('df_qbe_homebusiness','animalsdesc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'animalsdesc',
        datatype => 'explain',
        pretty_name => 'Describe',
        pretty_plural => 'Describe',
        default_value => '',
        sort_order => 230,
        table_name => '',
        column_name => 'animalsdesc',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- employees

    acs_attribute.drop_attribute ('df_qbe_homebusiness','employees');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'employees',
        datatype => 'enumeration',
        pretty_name => 'Are there any full or part-time employees connected to the business',
        pretty_plural => 'Are there any full or part-time employees connected to the business',
        default_value => '',
        sort_order => 240,
        table_name => '',
        column_name => 'employees',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- employeesfulltime

    acs_attribute.drop_attribute ('df_qbe_homebusiness','employeesfulltime');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'employeesfulltime',
        datatype => 'number',
        pretty_name => 'How many full-time',
        pretty_plural => 'How many full-time',
        default_value => '',
        sort_order => 250,
        table_name => '',
        column_name => 'employeesfulltime',
        min_n_values => 1,
        max_n_values => 999999
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- employeesparttime

    acs_attribute.drop_attribute ('df_qbe_homebusiness','employeesparttime');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'employeesparttime',
        datatype => 'number',
        pretty_name => 'How many part-time',
        pretty_plural => 'How many part-time',
        default_value => '',
        sort_order => 260,
        table_name => '',
        column_name => 'employeesparttime',
        min_n_values => 1,
        max_n_values => 999999
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- groupby1 -- Food Service 

    acs_attribute.drop_attribute ('df_qbe_homebusiness','groupby1');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'groupby1',
        datatype => 'groupby',
        pretty_name => 'Food Service',
        pretty_plural => 'Food Service',
        default_value => '',
        sort_order => 270,
        table_name => '',
        column_name => 'groupby1',
        min_n_values => 0,
        max_n_values => 1
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- businessfood

    acs_attribute.drop_attribute ('df_qbe_homebusiness','businessfood');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'businessfood',
        datatype => 'enumeration',
        pretty_name => 'Does the business involve food services?',
        pretty_plural => 'Does the business involve food services?',
        default_value => '',
        sort_order => 280,
        table_name => '',
        column_name => 'businessfood',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- ***************************************************
    -- commercialappliances

    acs_attribute.drop_attribute ('df_qbe_homebusiness','commercialappliances');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'commercialappliances',
        datatype => 'enumeration',
        pretty_name => 'Any commercial appliances',
        pretty_plural => 'Any commercial appliances',
        default_value => '',
        sort_order => 290,
        table_name => '',
        column_name => 'commercialappliances',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- commercialappliancesdesc

    acs_attribute.drop_attribute ('df_qbe_homebusiness','commercialappliancesdesc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'commercialappliancesdesc',
        datatype => 'explain',
        pretty_name => 'Describe',
        pretty_plural => 'Describe',
        default_value => '',
        sort_order => 300,
        table_name => '',
        column_name => 'commercialappliancesdesc',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- sprinklersystem

    acs_attribute.drop_attribute ('df_qbe_homebusiness','sprinklersystem');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'sprinklersystem',
        datatype => 'enumeration',
        pretty_name => 'Any sprinkler or Ansul system?',
        pretty_plural => 'Any sprinkler or Ansul system?',
        default_value => '',
        sort_order => 310,
        table_name => '',
        column_name => 'sprinklersystem',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- ***************************************************
    -- sprinklersystemdesc

    acs_attribute.drop_attribute ('df_qbe_homebusiness','sprinklersystemdesc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'sprinklersystemdesc',
        datatype => 'explain',
        pretty_name => 'Describe',
        pretty_plural => 'Describe',
        default_value => '',
        sort_order => 320,
        table_name => '',
        column_name => 'sprinklersystemdesc',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- ingredientslabeled

    acs_attribute.drop_attribute ('df_qbe_homebusiness','ingredientslabeled');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'ingredientslabeled',
        datatype => 'enumeration',
        pretty_name => 'Are food items and ingredients clearly labeled?',
        pretty_plural => 'Are food items and ingredients clearly labeled?',
        default_value => '',
        sort_order => 330,
        table_name => '',
        column_name => 'ingredientslabeled',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''NO''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- ingredientslabeleddesc

    acs_attribute.drop_attribute ('df_qbe_homebusiness','ingredientslabeleddesc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'ingredientslabeleddesc',
        datatype => 'explain',
        pretty_name => 'Describe',
        pretty_plural => 'Describe',
        default_value => '',
        sort_order => 340,
        table_name => '',
        column_name => 'ingredientslabeleddesc',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- foodareanotclean

    acs_attribute.drop_attribute ('df_qbe_homebusiness','foodareanotclean');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'foodareanotclean',
        datatype => 'enumeration',
        pretty_name => 'Does food area appear not clean and unsanitary',
        pretty_plural => 'Does food area appear not clean and unsanitary',
        default_value => '',
        sort_order => 350,
        table_name => '',
        column_name => 'foodareanotclean',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'YES', 'Yes', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NO', 'No', 20, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- foodareanotcleandesc

    acs_attribute.drop_attribute ('df_qbe_homebusiness','foodareanotcleandesc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_homebusiness',
        attribute_name => 'foodareanotcleandesc',
        datatype => 'explain',
        pretty_name => 'Describe',
        pretty_plural => 'Describe',
        default_value => '',
        sort_order => 360,
        table_name => '',
        column_name => 'foodareanotcleandesc',
        min_n_values => 1,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    v_result := hazard_rule.set_enabled(v_hazard_rule_id);
    commit;
end;
/
show errors;

delete dform_array_names where object_type = 'df_qbe_homebusiness';

insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/unabletocomplete','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/unabletocompletereason','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/businessdesc','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/businesslocation','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/businesshours','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/customersonsite','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/merchandiseforsale','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/merchandisedesc','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/insureditemssold','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/insureditemssolddesc','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/inventoryplace','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/inventorynumber','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/chemicalsonsite','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/chemicalsonsitedesc','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/itemsplace','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/specialequipment','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/specialequipmentdesc','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/housekeepingissues','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/housekeepingissuesdesc','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/deckporchcondition','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/deckporchconditiondesc','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/animals','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/animalsdesc','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/employees','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/employeesfulltime','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/employeesparttime','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/groupby1','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/businessfood','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/commercialappliances','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/commercialappliancesdesc','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/sprinklersystem','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/sprinklersystemdesc','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/ingredientslabeled','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/ingredientslabeleddesc','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/foodareanotclean','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_homebusiness', '/df_qbe_homebusiness/foodareanotcleandesc','dformv3');

commit;
-- build attributes
begin
    for rec in (select attribute_id
                from acs_attributes
                where object_type = 'df_qbe_homebusiness') loop
        build_attr_path(rec.attribute_id, rec.attribute_id, '');
    end loop;
end;
/

commit;
