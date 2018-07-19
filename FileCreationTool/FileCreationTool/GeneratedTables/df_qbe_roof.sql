drop table df_qbe_roofs purge;

create table df_qbe_roofs (
    object_id                         number constraint df_qbe_roof_nn not null,
    utcroof                           varchar2(100),
    utcreason                         varchar2(1000),
    roofinspectionconductedfrom       varchar2(100),
    estimateroofliferemaining         varchar2(100),
    roofrating                        varchar2(100),
    anypriordamagerepairs             varchar2(100),
    roofrepairsmade                   varchar2(100),
    roofstyle                         varchar2(100),
    roofpitch                         varchar2(100),
    excessivegranularloss             varchar2(100),
    impactmarks                       varchar2(100),
    missingshingles                   varchar2(100),
    roofpatched                       varchar2(100),
    patchtype                         varchar2(1000),
    constraint df_qbe_roof_pk primary key (object_id),
    constraint df_qbe_roof_fk foreign key (object_id) references acs_objects(object_id)
);

begin
    acs_object_type.drop_type ('df_qbe_roof','t');
    acs_object_type.create_type (
            object_type => 'df_qbe_roof',
            pretty_name => 'Roof',
            pretty_plural => 'Roof',
            supertype => 'form_abstract',
            table_name => 'df_qbe_roofs',
            id_column => 'object_id',
            package_name => 'df_qbe_roof',
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
    -- utcroof

    acs_attribute.drop_attribute ('df_qbe_roof','utcroof');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'utcroof',
        datatype => 'enumeration',
        pretty_name => 'Unable to complete (excluding weather conditions)',
        pretty_plural => 'Unable to complete (excluding weather conditions)',
        default_value => '',
        sort_order => 10,
        table_name => '',
        column_name => 'utcroof',
        min_n_values => 0,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 't');

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
    -- utcreason

    acs_attribute.drop_attribute ('df_qbe_roof','utcreason');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'utcreason',
        datatype => 'string',
        pretty_name => 'Reason Unable to complete',
        pretty_plural => 'Reason Unable to complete',
        default_value => '',
        sort_order => 20,
        table_name => '',
        column_name => 'utcreason',
        min_n_values => 0,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- roofinspectionconductedfrom

    acs_attribute.drop_attribute ('df_qbe_roof','roofinspectionconductedfrom');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'roofinspectionconductedfrom',
        datatype => 'enumeration',
        pretty_name => 'Roof Inspection Conducted From',
        pretty_plural => 'Roof Inspection Conducted From',
        default_value => '',
        sort_order => 30,
        table_name => '',
        column_name => 'roofinspectionconductedfrom',
        min_n_values => 0,
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
        (v_attribute_id, 'ROOFS', 'Roof Surface', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'ROOFS', 'Roof Surface', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'EAVES', 'Eaves/Ladder', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'EAVES', 'Eaves/Ladder', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'GROUN', 'Ground', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'GROUN', 'Ground', 30, 't', '', '', v_enum_id);

    -- ***************************************************
    -- estimateroofliferemaining

    acs_attribute.drop_attribute ('df_qbe_roof','estimateroofliferemaining');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'estimateroofliferemaining',
        datatype => 'enumeration',
        pretty_name => 'Estimate Roof Life Remaining',
        pretty_plural => 'Estimate Roof Life Remaining',
        default_value => '',
        sort_order => 40,
        table_name => '',
        column_name => 'estimateroofliferemaining',
        min_n_values => 0,
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
        (v_attribute_id, 'LESST', 'Less than 5', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'LESST', 'Less than 5', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, '5TO10', '5 to 10 years', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, '5TO10', '5 to 10 years', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'MORET', 'More than 10 years', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'MORET', 'More than 10 years', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UNABL', 'Unable to Verify', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UNABL', 'Unable to Verify', 40, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''LESST''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- roofrating

    acs_attribute.drop_attribute ('df_qbe_roof','roofrating');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'roofrating',
        datatype => 'enumeration',
        pretty_name => 'Roof Rating',
        pretty_plural => 'Roof Rating',
        default_value => '',
        sort_order => 50,
        table_name => '',
        column_name => 'roofrating',
        min_n_values => 0,
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
        (v_attribute_id, 'LIKEN', 'Like New', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'LIKEN', 'Like New', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NORMA', 'Normal Wear', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NORMA', 'Normal Wear', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'WORN', 'Worn', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'WORN', 'Worn', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NEEDS', 'Needs Repair', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NEEDS', 'Needs Repair', 40, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''WORN''', v_attribute_id, v_attribute_id, '11', '', null);
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''NEEDS''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- anypriordamagerepairs

    acs_attribute.drop_attribute ('df_qbe_roof','anypriordamagerepairs');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'anypriordamagerepairs',
        datatype => 'enumeration',
        pretty_name => 'Any Prior Damage/Repairs?',
        pretty_plural => 'Any Prior Damage/Repairs?',
        default_value => '',
        sort_order => 60,
        table_name => '',
        column_name => 'anypriordamagerepairs',
        min_n_values => 0,
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
    -- roofrepairsmade

    acs_attribute.drop_attribute ('df_qbe_roof','roofrepairsmade');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'roofrepairsmade',
        datatype => 'enumeration',
        pretty_name => 'Roof Repairs Made?',
        pretty_plural => 'Roof Repairs Made?',
        default_value => '',
        sort_order => 70,
        table_name => '',
        column_name => 'roofrepairsmade',
        min_n_values => 0,
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''NO''', v_attribute_id, v_attribute_id, '3', '', null);

    -- ***************************************************
    -- roofstyle

    acs_attribute.drop_attribute ('df_qbe_roof','roofstyle');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'roofstyle',
        datatype => 'enumeration',
        pretty_name => 'Roof Style:',
        pretty_plural => 'Roof Style:',
        default_value => '',
        sort_order => 80,
        table_name => '',
        column_name => 'roofstyle',
        min_n_values => 0,
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
        (v_attribute_id, 'FLAT', 'Flat', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'FLAT', 'Flat', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'GABLE', 'Gable', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'GABLE', 'Gable', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'GAMBR', 'Gambrel', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'GAMBR', 'Gambrel', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'HIP', 'Hip', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'HIP', 'Hip', 40, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'MANSA', 'Mansard', 50, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'MANSA', 'Mansard', 50, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'CUSTO', 'Custom/Complex', 60, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'CUSTO', 'Custom/Complex', 60, 't', '', '', v_enum_id);

    -- ***************************************************
    -- roofpitch

    acs_attribute.drop_attribute ('df_qbe_roof','roofpitch');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'roofpitch',
        datatype => 'enumeration',
        pretty_name => 'Roof Pitch:',
        pretty_plural => 'Roof Pitch:',
        default_value => '',
        sort_order => 90,
        table_name => '',
        column_name => 'roofpitch',
        min_n_values => 0,
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
        (v_attribute_id, 'FLAT', 'Flat', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'FLAT', 'Flat', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'SLIGH', 'Slight', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'SLIGH', 'Slight', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'MODER', 'Moderate', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'MODER', 'Moderate', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'STEEP', 'Steep', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'STEEP', 'Steep', 40, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'VERYS', 'Very Steep', 50, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'VERYS', 'Very Steep', 50, 't', '', '', v_enum_id);

    -- ***************************************************
    -- excessivegranularloss

    acs_attribute.drop_attribute ('df_qbe_roof','excessivegranularloss');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'excessivegranularloss',
        datatype => 'enumeration',
        pretty_name => 'Excessive Granular Loss',
        pretty_plural => 'Excessive Granular Loss',
        default_value => '',
        sort_order => 100,
        table_name => '',
        column_name => 'excessivegranularloss',
        min_n_values => 0,
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

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UNABL', 'Unable to Verify', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UNABL', 'Unable to Verify', 30, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '5', '', null);

    -- ***************************************************
    -- impactmarks

    acs_attribute.drop_attribute ('df_qbe_roof','impactmarks');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'impactmarks',
        datatype => 'enumeration',
        pretty_name => 'Impact Marks',
        pretty_plural => 'Impact Marks',
        default_value => '',
        sort_order => 110,
        table_name => '',
        column_name => 'impactmarks',
        min_n_values => 0,
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

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UNABL', 'Unable to Verify', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UNABL', 'Unable to Verify', 30, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '3', '', null);

    -- ***************************************************
    -- missingshingles

    acs_attribute.drop_attribute ('df_qbe_roof','missingshingles');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'missingshingles',
        datatype => 'enumeration',
        pretty_name => 'Missing Shingles',
        pretty_plural => 'Missing Shingles',
        default_value => '',
        sort_order => 120,
        table_name => '',
        column_name => 'missingshingles',
        min_n_values => 0,
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

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UNABL', 'Unable to Verify', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UNABL', 'Unable to Verify', 30, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '3', '', null);

    -- ***************************************************
    -- roofpatched

    acs_attribute.drop_attribute ('df_qbe_roof','roofpatched');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'roofpatched',
        datatype => 'enumeration',
        pretty_name => 'Roof Patched',
        pretty_plural => 'Roof Patched',
        default_value => '',
        sort_order => 130,
        table_name => '',
        column_name => 'roofpatched',
        min_n_values => 0,
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

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UNABL', 'Unable to Verify', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UNABL', 'Unable to Verify', 30, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '3', '', null);

    -- ***************************************************
    -- patchtype

    acs_attribute.drop_attribute ('df_qbe_roof','patchtype');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_roof',
        attribute_name => 'patchtype',
        datatype => 'string',
        pretty_name => '[if yes], Patch type:',
        pretty_plural => '[if yes], Patch type:',
        default_value => '',
        sort_order => 140,
        table_name => '',
        column_name => 'patchtype',
        min_n_values => 0,
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

delete dform_array_names where object_type = 'df_qbe_roof';

insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/utcroof','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/utcreason','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/roofinspectionconductedfrom','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/estimateroofliferemaining','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/roofrating','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/anypriordamagerepairs','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/roofrepairsmade','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/roofstyle','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/roofpitch','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/excessivegranularloss','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/impactmarks','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/missingshingles','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/roofpatched','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_roof', '/df_qbe_roof/patchtype','dformv3');

commit;
-- build attributes
begin
    for rec in (select attribute_id
                from acs_attributes
                where object_type = 'df_qbe_roof') loop
        build_attr_path(rec.attribute_id, rec.attribute_id, '');
    end loop;
end;
/

commit;
