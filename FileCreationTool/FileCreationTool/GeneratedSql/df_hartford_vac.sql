drop table df_hartford_vacs purge;

create table df_hartford_vacs (
    object_id                         number constraint df_hartford_vac_nn not null,
    mailaccumulation                  varchar2(100),
    electricmeteroff                  varchar2(100),
    gasmeteroff                       varchar2(100),
    winterized                        varchar2(100),
    personalpropprem                  varchar2(100),
    constraint df_hartford_vac_pk primary key (object_id),
    constraint df_hartford_vac_fk foreign key (object_id) references acs_objects(object_id)
);

begin
    acs_object_type.drop_type ('df_hartford_vac','t');
    acs_object_type.create_type (
            object_type => 'df_hartford_vac',
            pretty_name => 'Vacancy',
            pretty_plural => 'Vacancy',
            supertype => 'form_abstract',
            table_name => 'df_hartford_vacs',
            id_column => 'object_id',
            package_name => 'df_hartford_vac',
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
    select object_id into v_company_id from site_nodes where surl = '/EMI/Hartford/';

    select party_id into v_creator_id from parties where email = 'admin@myriad-development.com';
    v_hazard_rule_id := hazard_rule.new(i_company_id => v_company_id, i_description => 'Initial', i_effective_date => sysdate, i_creator_id => v_creator_id, i_hzd_weight_threshold => 11, i_hzd_count_threshold => 0);
    delete from rules_hazard_attributes where hazard_rule_id = v_hazard_rule_id and attribute_id not in (select attribute_id from acs_attributes);


    -- ***************************************************
    -- mailaccumulation

    acs_attribute.drop_attribute ('df_hartford_vac','mailaccumulation');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_vac',
        attribute_name => 'mailaccumulation',
        datatype => 'enumeration',
        pretty_name => 'Accumulation of Mail or Newspapers',
        pretty_plural => 'Accumulation of Mail or Newspapers',
        default_value => '',
        sort_order => 10,
        table_name => '',
        column_name => 'mailaccumulation',
        min_n_values => 1,
        max_n_values => 1
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

    -- ***************************************************
    -- electricmeteroff

    acs_attribute.drop_attribute ('df_hartford_vac','electricmeteroff');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_vac',
        attribute_name => 'electricmeteroff',
        datatype => 'enumeration',
        pretty_name => 'Electric Meter Turned Off?',
        pretty_plural => 'Electric Meter Turned Off?',
        default_value => '',
        sort_order => 20,
        table_name => '',
        column_name => 'electricmeteroff',
        min_n_values => 1,
        max_n_values => 1
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

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UTD', 'Unable to Determine', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UTD', 'Unable to Determine', 30, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- gasmeteroff

    acs_attribute.drop_attribute ('df_hartford_vac','gasmeteroff');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_vac',
        attribute_name => 'gasmeteroff',
        datatype => 'enumeration',
        pretty_name => 'Gas Meter Turned Off?',
        pretty_plural => 'Gas Meter Turned Off?',
        default_value => '',
        sort_order => 30,
        table_name => '',
        column_name => 'gasmeteroff',
        min_n_values => 1,
        max_n_values => 1
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

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UTD', 'Unable to Determine', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UTD', 'Unable to Determine', 30, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- winterized

    acs_attribute.drop_attribute ('df_hartford_vac','winterized');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_vac',
        attribute_name => 'winterized',
        datatype => 'enumeration',
        pretty_name => 'Signage stating utilities have been "Winterized"?',
        pretty_plural => 'Signage stating utilities have been "Winterized"?',
        default_value => '',
        sort_order => 40,
        table_name => '',
        column_name => 'winterized',
        min_n_values => 1,
        max_n_values => 1
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''NO''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- personalpropprem

    acs_attribute.drop_attribute ('df_hartford_vac','personalpropprem');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_vac',
        attribute_name => 'personalpropprem',
        datatype => 'enumeration',
        pretty_name => 'Is there evidence of personal property on the premise',
        pretty_plural => 'Is there evidence of personal property on the premise',
        default_value => '',
        sort_order => 50,
        table_name => '',
        column_name => 'personalpropprem',
        min_n_values => 1,
        max_n_values => 1
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

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UTD', 'Unable to Determine', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UTD', 'Unable to Determine', 30, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''NO''', v_attribute_id, v_attribute_id, '11', '', null);

    v_result := hazard_rule.set_enabled(v_hazard_rule_id);
    commit;
end;
/
show errors;

delete dform_array_names where object_type = 'df_hartford_vac';

insert into dform_array_names (object_type, name, form_version) values ('df_hartford_vac', '/df_hartford_vac/mailaccumulation','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_vac', '/df_hartford_vac/electricmeteroff','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_vac', '/df_hartford_vac/gasmeteroff','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_vac', '/df_hartford_vac/winterized','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_vac', '/df_hartford_vac/personalpropprem','dformv3');

commit;
-- build attributes
begin
    for rec in (select attribute_id
                from acs_attributes
                where object_type = 'df_hartford_vac') loop
        build_attr_path(rec.attribute_id, rec.attribute_id, '');
    end loop;
end;
/

commit;
