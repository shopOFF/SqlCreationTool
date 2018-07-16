drop table df_hartford_hurricanes purge;

create table df_hartford_hurricanes (
    object_id                         number constraint df_hartford_hurricane_nn not null,
    utc                               varchar2(100),
    utcexplain                        varchar2(4000),
    distwater                         varchar2(100),
    abovewater                        varchar2(100),
    namewater                         varchar2(200),
    glassopprot                       varchar2(100),
    glassoptype                       varchar2(100),
    basicshut                         varchar2(100),
    basicshutother                    varchar2(200),
    hurrshut                          varchar2(100),
    impreswdw                         varchar2(100),
    listmanuf                         varchar2(200),
    shutdet                           varchar2(200),
    shkylight                         varchar2(100),
    gdglass                           varchar2(100),
    gdbrace                           varchar2(100),
    funcgen                           varchar2(100),
    statues                           varchar2(100),
    boatyacht                         varchar2(100),
    constraint df_hartford_hurricane_pk primary key (object_id),
    constraint df_hartford_hurricane_fk foreign key (object_id) references acs_objects(object_id)
);

begin
    acs_object_type.drop_type ('df_hartford_hurricane','t');
    acs_object_type.create_type (
            object_type => 'df_hartford_hurricane',
            pretty_name => 'Hurricane',
            pretty_plural => 'Hurricane',
            supertype => 'form_abstract',
            table_name => 'df_hartford_hurricanes',
            id_column => 'object_id',
            package_name => 'df_hartford_hurricane',
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
    -- utc

    acs_attribute.drop_attribute ('df_hartford_hurricane','utc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'utc',
        datatype => 'enumeration',
        pretty_name => 'Unable to complete',
        pretty_plural => 'Unable to complete',
        default_value => '',
        sort_order => 10,
        table_name => '',
        column_name => 'utc',
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- utcexplain

    acs_attribute.drop_attribute ('df_hartford_hurricane','utcexplain');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'utcexplain',
        datatype => 'string',
        pretty_name => 'Reason Unable to complete',
        pretty_plural => 'Reason Unable to complete',
        default_value => '',
        sort_order => 20,
        table_name => '',
        column_name => 'utcexplain',
        min_n_values => 1,
        max_n_values => 4000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- distwater

    acs_attribute.drop_attribute ('df_hartford_hurricane','distwater');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'distwater',
        datatype => 'number',
        pretty_name => 'Distance from water (in feet):',
        pretty_plural => 'Distance from water (in feet):',
        default_value => '',
        sort_order => 30,
        table_name => '',
        column_name => 'distwater',
        min_n_values => 0,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- abovewater

    acs_attribute.drop_attribute ('df_hartford_hurricane','abovewater');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'abovewater',
        datatype => 'number',
        pretty_name => 'Height above water (in feet):',
        pretty_plural => 'Height above water (in feet):',
        default_value => '',
        sort_order => 40,
        table_name => '',
        column_name => 'abovewater',
        min_n_values => 0,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- namewater

    acs_attribute.drop_attribute ('df_hartford_hurricane','namewater');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'namewater',
        datatype => 'string',
        pretty_name => 'List name of the waterway:',
        pretty_plural => 'List name of the waterway:',
        default_value => '',
        sort_order => 50,
        table_name => '',
        column_name => 'namewater',
        min_n_values => 1,
        max_n_values => 200
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- glassopprot

    acs_attribute.drop_attribute ('df_hartford_hurricane','glassopprot');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'glassopprot',
        datatype => 'enumeration',
        pretty_name => 'Glass Opening Protection?',
        pretty_plural => 'Glass Opening Protection?',
        default_value => '',
        sort_order => 60,
        table_name => '',
        column_name => 'glassopprot',
        min_n_values => 1,
        max_n_values => 1
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
    -- glassoptype

    acs_attribute.drop_attribute ('df_hartford_hurricane','glassoptype');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'glassoptype',
        datatype => 'enumeration',
        pretty_name => 'Glass Opening Protection Type:',
        pretty_plural => 'Glass Opening Protection Type:',
        default_value => '',
        sort_order => 70,
        table_name => '',
        column_name => 'glassoptype',
        min_n_values => 1,
        max_n_values => 1
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
        (v_attribute_id, 'BS', 'Basic Shutters', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'BS', 'Basic Shutters', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'HS', 'Hurricane Shutters', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'HS', 'Hurricane Shutters', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'IRWG', 'Impact Resistant Window Glazing', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'IRWG', 'Impact Resistant Window Glazing', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NONE', 'None', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NONE', 'None', 40, 't', '', '', v_enum_id);

    -- ***************************************************
    -- basicshut

    acs_attribute.drop_attribute ('df_hartford_hurricane','basicshut');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'basicshut',
        datatype => 'enumeration',
        pretty_name => 'Basic Shutters:',
        pretty_plural => 'Basic Shutters:',
        default_value => '',
        sort_order => 80,
        table_name => '',
        column_name => 'basicshut',
        min_n_values => 1,
        max_n_values => 1
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
        (v_attribute_id, 'PLW', 'Plywood', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'PLW', 'Plywood', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'ALUM', 'Aluminum', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'ALUM', 'Aluminum', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'STL', 'Steel', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'STL', 'Steel', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'OTH', 'Other', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'OTH', 'Other', 40, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''PLYWOOD''', v_attribute_id, v_attribute_id, '5', '', null);

    -- ***************************************************
    -- basicshutother

    acs_attribute.drop_attribute ('df_hartford_hurricane','basicshutother');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'basicshutother',
        datatype => 'string',
        pretty_name => 'Basic Shutters Other:',
        pretty_plural => 'Basic Shutters Other:',
        default_value => '',
        sort_order => 90,
        table_name => '',
        column_name => 'basicshutother',
        min_n_values => 1,
        max_n_values => 200
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- hurrshut

    acs_attribute.drop_attribute ('df_hartford_hurricane','hurrshut');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'hurrshut',
        datatype => 'enumeration',
        pretty_name => 'Hurricane Shutters:',
        pretty_plural => 'Hurricane Shutters:',
        default_value => '',
        sort_order => 100,
        table_name => '',
        column_name => 'hurrshut',
        min_n_values => 1,
        max_n_values => 1
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
        (v_attribute_id, 'ACC', 'Accordion', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'ACC', 'Accordion', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'COL', 'Colonial', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'COL', 'Colonial', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'BAH', 'Bahama', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'BAH', 'Bahama', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'AWN', 'Awning', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'AWN', 'Awning', 40, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'CS', 'Clam shell', 50, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'CS', 'Clam shell', 50, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'RUD', 'Roll Up/Down', 60, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'RUD', 'Roll Up/Down', 60, 't', '', '', v_enum_id);

    -- ***************************************************
    -- impreswdw

    acs_attribute.drop_attribute ('df_hartford_hurricane','impreswdw');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'impreswdw',
        datatype => 'enumeration',
        pretty_name => 'Impact Resistant Window Glazing',
        pretty_plural => 'Impact Resistant Window Glazing',
        default_value => '',
        sort_order => 110,
        table_name => '',
        column_name => 'impreswdw',
        min_n_values => 1,
        max_n_values => 1
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
    -- listmanuf

    acs_attribute.drop_attribute ('df_hartford_hurricane','listmanuf');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'listmanuf',
        datatype => 'string',
        pretty_name => 'List the manufacturer(s) of the protective devices.',
        pretty_plural => 'List the manufacturer(s) of the protective devices.',
        default_value => '',
        sort_order => 120,
        table_name => '',
        column_name => 'listmanuf',
        min_n_values => 1,
        max_n_values => 200
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- shutdet

    acs_attribute.drop_attribute ('df_hartford_hurricane','shutdet');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'shutdet',
        datatype => 'string',
        pretty_name => 'How was shutter type determined?',
        pretty_plural => 'How was shutter type determined?',
        default_value => '',
        sort_order => 130,
        table_name => '',
        column_name => 'shutdet',
        min_n_values => 1,
        max_n_values => 200
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- shkylight

    acs_attribute.drop_attribute ('df_hartford_hurricane','shkylight');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'shkylight',
        datatype => 'enumeration',
        pretty_name => 'Are there skylights present?',
        pretty_plural => 'Are there skylights present?',
        default_value => '',
        sort_order => 140,
        table_name => '',
        column_name => 'shkylight',
        min_n_values => 1,
        max_n_values => 1
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
    -- gdglass

    acs_attribute.drop_attribute ('df_hartford_hurricane','gdglass');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'gdglass',
        datatype => 'enumeration',
        pretty_name => 'Are there glass openings in the garage doors?',
        pretty_plural => 'Are there glass openings in the garage doors?',
        default_value => '',
        sort_order => 150,
        table_name => '',
        column_name => 'gdglass',
        min_n_values => 1,
        max_n_values => 1
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
    -- gdbrace

    acs_attribute.drop_attribute ('df_hartford_hurricane','gdbrace');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'gdbrace',
        datatype => 'enumeration',
        pretty_name => 'Do garage doors have hurricane bracing?',
        pretty_plural => 'Do garage doors have hurricane bracing?',
        default_value => '',
        sort_order => 160,
        table_name => '',
        column_name => 'gdbrace',
        min_n_values => 1,
        max_n_values => 1
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
    -- funcgen

    acs_attribute.drop_attribute ('df_hartford_hurricane','funcgen');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'funcgen',
        datatype => 'enumeration',
        pretty_name => 'Is there a functioning backup generator?',
        pretty_plural => 'Is there a functioning backup generator?',
        default_value => '',
        sort_order => 170,
        table_name => '',
        column_name => 'funcgen',
        min_n_values => 1,
        max_n_values => 1
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
    -- statues

    acs_attribute.drop_attribute ('df_hartford_hurricane','statues');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'statues',
        datatype => 'enumeration',
        pretty_name => 'Are exterior statues, fountains, sculptures present?',
        pretty_plural => 'Are exterior statues, fountains, sculptures present?',
        default_value => '',
        sort_order => 180,
        table_name => '',
        column_name => 'statues',
        min_n_values => 1,
        max_n_values => 1
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
    -- boatyacht

    acs_attribute.drop_attribute ('df_hartford_hurricane','boatyacht');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_hurricane',
        attribute_name => 'boatyacht',
        datatype => 'enumeration',
        pretty_name => 'Is there a boat or a yacht?',
        pretty_plural => 'Is there a boat or a yacht?',
        default_value => '',
        sort_order => 190,
        table_name => '',
        column_name => 'boatyacht',
        min_n_values => 1,
        max_n_values => 1
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

    v_result := hazard_rule.set_enabled(v_hazard_rule_id);
    commit;
end;
/
show errors;

delete dform_array_names where object_type = 'df_hartford_hurricane';

insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/utc','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/utcexplain','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/distwater','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/abovewater','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/namewater','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/glassopprot','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/glassoptype','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/basicshut','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/basicshutother','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/hurrshut','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/impreswdw','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/listmanuf','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/shutdet','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/shkylight','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/gdglass','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/gdbrace','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/funcgen','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/statues','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_hurricane', '/df_hartford_hurricane/boatyacht','dformv3');

commit;
-- build attributes
begin
    for rec in (select attribute_id
                from acs_attributes
                where object_type = 'df_hartford_hurricane') loop
        build_attr_path(rec.attribute_id, rec.attribute_id, '');
    end loop;
end;
/

commit;
