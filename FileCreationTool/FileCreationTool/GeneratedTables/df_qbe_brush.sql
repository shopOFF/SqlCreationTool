drop table df_qbe_brushs purge;

create table df_qbe_brushs (
    object_id                         number constraint df_qbe_brush_nn not null,
    interview                         varchar2(100),
    interviewname                     varchar2(1000),
    occupancy                         varchar2(100),
    dwellingtype                      varchar2(100),
    dwellingage                       varchar2(1000),
    stories                           varchar2(100),
    construction                      varchar2(100),
    exteriorwalls                     varchar2(1000),
    exteriorwallsother                varchar2(1000),
    rooftype                          varchar2(100),
    withincitylimits                  varchar2(100),
    roofwoodtreated                   varchar2(100),
    roofsprinklered                   varchar2(100),
    chimneysparkarrestor              varchar2(100),
    twoaccessroutes                   varchar2(100),
    pavedaccess                       varchar2(100),
    homevisible                       varchar2(100),
    windingstreet                     varchar2(100),
    deadendstreet                     varchar2(100),
    northbrushdist                    varchar2(200),
    northbrushtype                    varchar2(100),
    northbrushslope                   varchar2(100),
    southbrushdist                    varchar2(200),
    southbrushtype                    varchar2(100),
    southbrushslope                   varchar2(100),
    eastbrushdist                     varchar2(200),
    eastbrushtype                     varchar2(100),
    eastbrushslope                    varchar2(100),
    westbrushdist                     varchar2(200),
    westbrushtype                     varchar2(100),
    westbrushslope                    varchar2(100),
    vegetationdensity                 varchar2(100),
    vegetationcleared                 varchar2(100),
    landscapedensity                  varchar2(100),
    openfoundation                    varchar2(100),
    brushunderhouse                   varchar2(100),
    overhangingtrees                  varchar2(100),
    leavesonroof                      varchar2(100),
    vacantorseasonal                  varchar2(100),
    poorupkeep                        varchar2(100),
    additionalcomments                varchar2(4000),
    constraint df_qbe_brush_pk primary key (object_id),
    constraint df_qbe_brush_fk foreign key (object_id) references acs_objects(object_id)
);

begin
    acs_object_type.drop_type ('df_qbe_brush','t');
    acs_object_type.create_type (
            object_type => 'df_qbe_brush',
            pretty_name => 'Brush',
            pretty_plural => 'Brush',
            supertype => 'form_abstract',
            table_name => 'df_qbe_brushs',
            id_column => 'object_id',
            package_name => 'df_qbe_brush',
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
    select object_id into v_company_id from site_nodes where surl = '/EMI/Qbe/';

    select party_id into v_creator_id from parties where email = 'admin@myriad-development.com';
    v_hazard_rule_id := hazard_rule.new(i_company_id => v_company_id, i_description => 'Initial', i_effective_date => sysdate, i_creator_id => v_creator_id, i_hzd_weight_threshold => 11, i_hzd_count_threshold => 0);
    delete from rules_hazard_attributes where hazard_rule_id = v_hazard_rule_id and attribute_id not in (select attribute_id from acs_attributes);


    -- ***************************************************
    -- groupby1

    acs_attribute.drop_attribute ('df_qbe_brush','groupby1');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'groupby1',
        datatype => 'groupby',
        pretty_name => 'CUSTOMER',
        pretty_plural => 'CUSTOMER',
        default_value => '',
        sort_order => 10,
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
    -- interview

    acs_attribute.drop_attribute ('df_qbe_brush','interview');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'interview',
        datatype => 'enumeration',
        pretty_name => 'Person Interviewed',
        pretty_plural => 'Person Interviewed',
        default_value => '',
        sort_order => 20,
        table_name => '',
        column_name => 'interview',
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

    -- ***************************************************
    -- interviewname

    acs_attribute.drop_attribute ('df_qbe_brush','interviewname');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'interviewname',
        datatype => 'string',
        pretty_name => 'Name of Person Interviewed',
        pretty_plural => 'Name of Person Interviewed',
        default_value => '',
        sort_order => 30,
        table_name => '',
        column_name => 'interviewname',
        min_n_values => 0,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- occupancy

    acs_attribute.drop_attribute ('df_qbe_brush','occupancy');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'occupancy',
        datatype => 'enumeration',
        pretty_name => 'Occupant',
        pretty_plural => 'Occupant',
        default_value => '',
        sort_order => 40,
        table_name => '',
        column_name => 'occupancy',
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
        (v_attribute_id, 'OWNR', 'Owner', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'OWNR', 'Owner', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'TENANT', 'Tenant', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'TENANT', 'Tenant', 20, 't', '', '', v_enum_id);

    -- ***************************************************
    -- groupby2

    acs_attribute.drop_attribute ('df_qbe_brush','groupby2');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'groupby2',
        datatype => 'groupby',
        pretty_name => 'PHYSICAL',
        pretty_plural => 'PHYSICAL',
        default_value => '',
        sort_order => 50,
        table_name => '',
        column_name => 'groupby2',
        min_n_values => 0,
        max_n_values => 1
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- dwellingtype

    acs_attribute.drop_attribute ('df_qbe_brush','dwellingtype');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'dwellingtype',
        datatype => 'enumeration',
        pretty_name => 'Dwelling Type',
        pretty_plural => 'Dwelling Type',
        default_value => '',
        sort_order => 60,
        table_name => '',
        column_name => 'dwellingtype',
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
        (v_attribute_id, 'SINGL', 'Single', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'SINGL', 'Single', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'DUP', 'Duplex', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'DUP', 'Duplex', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'TRIPLX', 'Triplex', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'TRIPLX', 'Triplex', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'FPLX', 'Fourplex', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'FPLX', 'Fourplex', 40, 't', '', '', v_enum_id);

    -- ***************************************************
    -- dwellingage

    acs_attribute.drop_attribute ('df_qbe_brush','dwellingage');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'dwellingage',
        datatype => 'string',
        pretty_name => 'Dwelling Age',
        pretty_plural => 'Dwelling Age',
        default_value => '',
        sort_order => 70,
        table_name => '',
        column_name => 'dwellingage',
        min_n_values => 0,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- stories

    acs_attribute.drop_attribute ('df_qbe_brush','stories');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'stories',
        datatype => 'enumeration',
        pretty_name => 'Number of Stories',
        pretty_plural => 'Number of Stories',
        default_value => '',
        sort_order => 80,
        table_name => '',
        column_name => 'stories',
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
        (v_attribute_id, '1', '1 Story', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, '1', '1 Story', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, '1.5', '1.5 Stories', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, '1.5', '1.5 Stories', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, '2', '2 Stories', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, '2', '2 Stories', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, '2.5', '2.5 Stories', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, '2.5', '2.5 Stories', 40, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, '3', '3 Stories', 50, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, '3', '3 Stories', 50, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, '3.5', '3.5 Stories', 60, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, '3.5', '3.5 Stories', 60, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, '4', '4 Level Split', 70, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, '4', '4 Level Split', 70, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, '4LS', '4 Stories', 80, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, '4LS', '4 Stories', 80, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'BILVL', 'Bi-level', 90, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'BILVL', 'Bi-level', 90, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'TRILVL', 'Tri-level', 100, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'TRILVL', 'Tri-level', 100, 't', '', '', v_enum_id);

    -- ***************************************************
    -- construction

    acs_attribute.drop_attribute ('df_qbe_brush','construction');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'construction',
        datatype => 'enumeration',
        pretty_name => 'Construction',
        pretty_plural => 'Construction',
        default_value => ' if inspection answer is Mobile Home and Policy Type not in ( F02,F03,F05) then hazard weight of 11

 If inspection answer is Mobile Home and Policy Type in (F02,F03,F05) then hazard weight of 3',
        sort_order => 90,
        table_name => '',
        column_name => 'construction',
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
        (v_attribute_id, 'BLK', 'Block', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'BLK', 'Block', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'BRCK', 'Brick', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'BRCK', 'Brick', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'FRME', 'Frame', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'FRME', 'Frame', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'MH', 'Mobile Home', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'MH', 'Mobile Home', 40, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'MODHME', 'Modular Home', 50, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'MODHME', 'Modular Home', 50, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''FRME''', v_attribute_id, v_attribute_id, '3', '', null);
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''MODHME''', v_attribute_id, v_attribute_id, '3', '', null);

    -- ***************************************************
    -- exteriorwalls

    acs_attribute.drop_attribute ('df_qbe_brush','exteriorwalls');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'exteriorwalls',
        datatype => 'enumeration',
        pretty_name => 'Faced with',
        pretty_plural => 'Faced with',
        default_value => '',
        sort_order => 100,
        table_name => '',
        column_name => 'exteriorwalls',
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
        (v_attribute_id, 'WOOD', 'Wood Siding', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'WOOD', 'Wood Siding', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'STCCO', 'Stucco', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'STCCO', 'Stucco', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'BRKVENR', 'Brick Veneer', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'BRKVENR', 'Brick Veneer', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'COMP', 'Composition', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'COMP', 'Composition', 40, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'EIFS', 'EIFS', 50, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'EIFS', 'EIFS', 50, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'OTHER', 'Other', 60, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'OTHER', 'Other', 60, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''WOOD''', v_attribute_id, v_attribute_id, '3', '', null);
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''EIFS''', v_attribute_id, v_attribute_id, '3', '', null);

    -- ***************************************************
    -- exteriorwallsother

    acs_attribute.drop_attribute ('df_qbe_brush','exteriorwallsother');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'exteriorwallsother',
        datatype => 'string',
        pretty_name => 'If Other, explain',
        pretty_plural => 'If Other, explain',
        default_value => '',
        sort_order => 110,
        table_name => '',
        column_name => 'exteriorwallsother',
        min_n_values => 0,
        max_n_values => 1000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- rooftype

    acs_attribute.drop_attribute ('df_qbe_brush','rooftype');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'rooftype',
        datatype => 'enumeration',
        pretty_name => 'Roof Type',
        pretty_plural => 'Roof Type',
        default_value => '',
        sort_order => 120,
        table_name => '',
        column_name => 'rooftype',
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
        (v_attribute_id, 'COMP', 'Composition Shingle', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'COMP', 'Composition Shingle', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'CLAY', 'Clay Tile', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'CLAY', 'Clay Tile', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'TARGRVL', 'Tar and Gravel', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'TARGRVL', 'Tar and Gravel', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'WOOD', 'Wood Shake', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'WOOD', 'Wood Shake', 40, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'CONC', 'Concrete Tile', 50, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'CONC', 'Concrete Tile', 50, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'OTHER', 'Other', 60, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'OTHER', 'Other', 60, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''WOOD''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- groupby3

    acs_attribute.drop_attribute ('df_qbe_brush','groupby3');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'groupby3',
        datatype => 'groupby',
        pretty_name => 'PROTECTION',
        pretty_plural => 'PROTECTION',
        default_value => '',
        sort_order => 130,
        table_name => '',
        column_name => 'groupby3',
        min_n_values => 0,
        max_n_values => 1
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- withincitylimits

    acs_attribute.drop_attribute ('df_qbe_brush','withincitylimits');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'withincitylimits',
        datatype => 'enumeration',
        pretty_name => 'Is dwelling inside city limits?',
        pretty_plural => 'Is dwelling inside city limits?',
        default_value => '',
        sort_order => 140,
        table_name => '',
        column_name => 'withincitylimits',
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
    -- roofwoodtreated

    acs_attribute.drop_attribute ('df_qbe_brush','roofwoodtreated');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'roofwoodtreated',
        datatype => 'enumeration',
        pretty_name => 'Has the wood shake roof been treated?',
        pretty_plural => 'Has the wood shake roof been treated?',
        default_value => '',
        sort_order => 150,
        table_name => '',
        column_name => 'roofwoodtreated',
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
        (v_attribute_id, 'NA', 'N/A', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NA', 'N/A', 30, 't', '', '', v_enum_id);

    -- ***************************************************
    -- roofsprinklered

    acs_attribute.drop_attribute ('df_qbe_brush','roofsprinklered');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'roofsprinklered',
        datatype => 'enumeration',
        pretty_name => 'Is the roof sprinklered?',
        pretty_plural => 'Is the roof sprinklered?',
        default_value => '',
        sort_order => 160,
        table_name => '',
        column_name => 'roofsprinklered',
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
    -- chimneysparkarrestor

    acs_attribute.drop_attribute ('df_qbe_brush','chimneysparkarrestor');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'chimneysparkarrestor',
        datatype => 'enumeration',
        pretty_name => 'Does the chimney have a spark arrestor?',
        pretty_plural => 'Does the chimney have a spark arrestor?',
        default_value => '',
        sort_order => 170,
        table_name => '',
        column_name => 'chimneysparkarrestor',
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
    -- groupby4

    acs_attribute.drop_attribute ('df_qbe_brush','groupby4');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'groupby4',
        datatype => 'groupby',
        pretty_name => 'ACCESSIBILITY',
        pretty_plural => 'ACCESSIBILITY',
        default_value => '',
        sort_order => 180,
        table_name => '',
        column_name => 'groupby4',
        min_n_values => 0,
        max_n_values => 1
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- twoaccessroutes

    acs_attribute.drop_attribute ('df_qbe_brush','twoaccessroutes');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'twoaccessroutes',
        datatype => 'enumeration',
        pretty_name => 'Can the house be accessed from at least two different routes?',
        pretty_plural => 'Can the house be accessed from at least two different routes?',
        default_value => '',
        sort_order => 190,
        table_name => '',
        column_name => 'twoaccessroutes',
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
    -- pavedaccess

    acs_attribute.drop_attribute ('df_qbe_brush','pavedaccess');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'pavedaccess',
        datatype => 'enumeration',
        pretty_name => 'Is the access road paved?',
        pretty_plural => 'Is the access road paved?',
        default_value => '',
        sort_order => 200,
        table_name => '',
        column_name => 'pavedaccess',
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
    -- homevisible

    acs_attribute.drop_attribute ('df_qbe_brush','homevisible');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'homevisible',
        datatype => 'enumeration',
        pretty_name => 'Is the house address clearly visible from the street?',
        pretty_plural => 'Is the house address clearly visible from the street?',
        default_value => '',
        sort_order => 210,
        table_name => '',
        column_name => 'homevisible',
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
    -- windingstreet

    acs_attribute.drop_attribute ('df_qbe_brush','windingstreet');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'windingstreet',
        datatype => 'enumeration',
        pretty_name => 'Is the access street winding?',
        pretty_plural => 'Is the access street winding?',
        default_value => '',
        sort_order => 220,
        table_name => '',
        column_name => 'windingstreet',
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
    -- deadendstreet

    acs_attribute.drop_attribute ('df_qbe_brush','deadendstreet');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'deadendstreet',
        datatype => 'enumeration',
        pretty_name => 'Is the house on a dead end street?',
        pretty_plural => 'Is the house on a dead end street?',
        default_value => '',
        sort_order => 230,
        table_name => '',
        column_name => 'deadendstreet',
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
    -- groupby5

    acs_attribute.drop_attribute ('df_qbe_brush','groupby5');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'groupby5',
        datatype => 'groupby',
        pretty_name => 'BRUSH AND RELATED EXPOSURES',
        pretty_plural => 'BRUSH AND RELATED EXPOSURES',
        default_value => '',
        sort_order => 240,
        table_name => '',
        column_name => 'groupby5',
        min_n_values => 0,
        max_n_values => 1
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- northbrushdist

    acs_attribute.drop_attribute ('df_qbe_brush','northbrushdist');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'northbrushdist',
        datatype => 'number',
        pretty_name => 'North - Distance (feet)',
        pretty_plural => 'North - Distance (feet)',
        default_value => 'If < 1000 ft hazard trigger hazard weight of 11',
        sort_order => 250,
        table_name => '',
        column_name => 'northbrushdist',
        min_n_values => 0,
        max_n_values => 200
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- northbrushtype

    acs_attribute.drop_attribute ('df_qbe_brush','northbrushtype');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'northbrushtype',
        datatype => 'enumeration',
        pretty_name => 'North - Type',
        pretty_plural => 'North - Type',
        default_value => '',
        sort_order => 260,
        table_name => '',
        column_name => 'northbrushtype',
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
        (v_attribute_id, 'FOREST', 'Forest Areas', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'FOREST', 'Forest Areas', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'BRUSH', 'Brush', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'BRUSH', 'Brush', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NATIVE', 'Native Growth', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NATIVE', 'Native Growth', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'WILD', 'Wild Grass', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'WILD', 'Wild Grass', 40, 't', '', '', v_enum_id);

    -- ***************************************************
    -- northbrushslope

    acs_attribute.drop_attribute ('df_qbe_brush','northbrushslope');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'northbrushslope',
        datatype => 'enumeration',
        pretty_name => 'North - Property on a 20 degree Slope',
        pretty_plural => 'North - Property on a 20 degree Slope',
        default_value => '',
        sort_order => 270,
        table_name => '',
        column_name => 'northbrushslope',
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- southbrushdist

    acs_attribute.drop_attribute ('df_qbe_brush','southbrushdist');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'southbrushdist',
        datatype => 'number',
        pretty_name => 'South - Distance (feet)',
        pretty_plural => 'South - Distance (feet)',
        default_value => 'If < 1000 ft hazard trigger hazard weight of 11',
        sort_order => 280,
        table_name => '',
        column_name => 'southbrushdist',
        min_n_values => 0,
        max_n_values => 200
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- southbrushtype

    acs_attribute.drop_attribute ('df_qbe_brush','southbrushtype');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'southbrushtype',
        datatype => 'enumeration',
        pretty_name => 'South - Type',
        pretty_plural => 'South - Type',
        default_value => '',
        sort_order => 290,
        table_name => '',
        column_name => 'southbrushtype',
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
        (v_attribute_id, 'FOREST', 'Forest Areas', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'FOREST', 'Forest Areas', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'BRUSH', 'Brush', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'BRUSH', 'Brush', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NATIVE', 'Native Growth', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NATIVE', 'Native Growth', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'WILD', 'Wild Grass', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'WILD', 'Wild Grass', 40, 't', '', '', v_enum_id);

    -- ***************************************************
    -- southbrushslope

    acs_attribute.drop_attribute ('df_qbe_brush','southbrushslope');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'southbrushslope',
        datatype => 'enumeration',
        pretty_name => 'South - Property on a 20 degree Slope',
        pretty_plural => 'South - Property on a 20 degree Slope',
        default_value => '',
        sort_order => 300,
        table_name => '',
        column_name => 'southbrushslope',
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- eastbrushdist

    acs_attribute.drop_attribute ('df_qbe_brush','eastbrushdist');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'eastbrushdist',
        datatype => 'number',
        pretty_name => 'East - Distance (feet)',
        pretty_plural => 'East - Distance (feet)',
        default_value => 'If < 1000 ft hazard trigger hazard weight of 11',
        sort_order => 310,
        table_name => '',
        column_name => 'eastbrushdist',
        min_n_values => 0,
        max_n_values => 200
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- eastbrushtype

    acs_attribute.drop_attribute ('df_qbe_brush','eastbrushtype');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'eastbrushtype',
        datatype => 'enumeration',
        pretty_name => 'East - Type',
        pretty_plural => 'East - Type',
        default_value => '',
        sort_order => 320,
        table_name => '',
        column_name => 'eastbrushtype',
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
        (v_attribute_id, 'FOREST', 'Forest Areas', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'FOREST', 'Forest Areas', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'BRUSH', 'Brush', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'BRUSH', 'Brush', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NATIVE', 'Native Growth', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NATIVE', 'Native Growth', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'WILD', 'Wild Grass', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'WILD', 'Wild Grass', 40, 't', '', '', v_enum_id);

    -- ***************************************************
    -- eastbrushslope

    acs_attribute.drop_attribute ('df_qbe_brush','eastbrushslope');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'eastbrushslope',
        datatype => 'enumeration',
        pretty_name => 'East- Property on a 20 degree Slope',
        pretty_plural => 'East- Property on a 20 degree Slope',
        default_value => '',
        sort_order => 330,
        table_name => '',
        column_name => 'eastbrushslope',
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- westbrushdist

    acs_attribute.drop_attribute ('df_qbe_brush','westbrushdist');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'westbrushdist',
        datatype => 'number',
        pretty_name => 'West - Distance (feet)',
        pretty_plural => 'West - Distance (feet)',
        default_value => 'If < 1000 ft hazard trigger hazard weight of 11',
        sort_order => 340,
        table_name => '',
        column_name => 'westbrushdist',
        min_n_values => 0,
        max_n_values => 200
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- westbrushtype

    acs_attribute.drop_attribute ('df_qbe_brush','westbrushtype');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'westbrushtype',
        datatype => 'enumeration',
        pretty_name => 'West - Type',
        pretty_plural => 'West - Type',
        default_value => '',
        sort_order => 350,
        table_name => '',
        column_name => 'westbrushtype',
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
        (v_attribute_id, 'BRUSH', 'Brush', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'BRUSH', 'Brush', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'FOREST', 'Forest Areas', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'FOREST', 'Forest Areas', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NATIVE', 'Native Growth', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NATIVE', 'Native Growth', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'WILD', 'Wild Grass', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'WILD', 'Wild Grass', 40, 't', '', '', v_enum_id);

    -- ***************************************************
    -- westbrushslope

    acs_attribute.drop_attribute ('df_qbe_brush','westbrushslope');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'westbrushslope',
        datatype => 'enumeration',
        pretty_name => 'West- Property on a 20 degree Slope',
        pretty_plural => 'West- Property on a 20 degree Slope',
        default_value => '',
        sort_order => 360,
        table_name => '',
        column_name => 'westbrushslope',
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- vegetationdensity

    acs_attribute.drop_attribute ('df_qbe_brush','vegetationdensity');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'vegetationdensity',
        datatype => 'enumeration',
        pretty_name => 'The above vegetation is:',
        pretty_plural => 'The above vegetation is:',
        default_value => '',
        sort_order => 370,
        table_name => '',
        column_name => 'vegetationdensity',
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
        (v_attribute_id, 'DENSE', 'Dense', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'DENSE', 'Dense', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'MEDIUM', 'Medium', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'MEDIUM', 'Medium', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'SPARSE', 'Sparse', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'SPARSE', 'Sparse', 30, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''DENSE''', v_attribute_id, v_attribute_id, '11', '', null);
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''MEDIUM''', v_attribute_id, v_attribute_id, '5', '', null);
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''SPARSE''', v_attribute_id, v_attribute_id, '0', '', null);

    -- ***************************************************
    -- vegetationcleared

    acs_attribute.drop_attribute ('df_qbe_brush','vegetationcleared');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'vegetationcleared',
        datatype => 'enumeration',
        pretty_name => 'Is there defencible space >= 100 feet?',
        pretty_plural => 'Is there defencible space >= 100 feet?',
        default_value => '',
        sort_order => 380,
        table_name => '',
        column_name => 'vegetationcleared',
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''NO''', v_attribute_id, v_attribute_id, '5', '', null);

    -- ***************************************************
    -- landscapedensity

    acs_attribute.drop_attribute ('df_qbe_brush','landscapedensity');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'landscapedensity',
        datatype => 'enumeration',
        pretty_name => 'Planted landscaping is:',
        pretty_plural => 'Planted landscaping is:',
        default_value => '',
        sort_order => 390,
        table_name => '',
        column_name => 'landscapedensity',
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
        (v_attribute_id, 'DENSE', 'Dense', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'DENSE', 'Dense', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'MEDIUM', 'Medium', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'MEDIUM', 'Medium', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'SPARSE', 'Sparse', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'SPARSE', 'Sparse', 30, 't', '', '', v_enum_id);

    -- Hazards
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''DENSE''', v_attribute_id, v_attribute_id, '5', '', null);
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''MEDIUM''', v_attribute_id, v_attribute_id, '3', '', null);
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''SPARSE''', v_attribute_id, v_attribute_id, '0', '', null);

    -- ***************************************************
    -- openfoundation

    acs_attribute.drop_attribute ('df_qbe_brush','openfoundation');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'openfoundation',
        datatype => 'enumeration',
        pretty_name => 'Does the house have an open foundation?',
        pretty_plural => 'Does the house have an open foundation?',
        default_value => '',
        sort_order => 400,
        table_name => '',
        column_name => 'openfoundation',
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- brushunderhouse

    acs_attribute.drop_attribute ('df_qbe_brush','brushunderhouse');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'brushunderhouse',
        datatype => 'enumeration',
        pretty_name => 'Any visible brush or debris under the house?',
        pretty_plural => 'Any visible brush or debris under the house?',
        default_value => '',
        sort_order => 410,
        table_name => '',
        column_name => 'brushunderhouse',
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '5', '', null);

    -- ***************************************************
    -- overhangingtrees

    acs_attribute.drop_attribute ('df_qbe_brush','overhangingtrees');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'overhangingtrees',
        datatype => 'enumeration',
        pretty_name => 'Are tall trees overhanging the roof?',
        pretty_plural => 'Are tall trees overhanging the roof?',
        default_value => '',
        sort_order => 420,
        table_name => '',
        column_name => 'overhangingtrees',
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '3', '', null);

    -- ***************************************************
    -- leavesonroof

    acs_attribute.drop_attribute ('df_qbe_brush','leavesonroof');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'leavesonroof',
        datatype => 'enumeration',
        pretty_name => 'Any visible needles or leaves on the roof?',
        pretty_plural => 'Any visible needles or leaves on the roof?',
        default_value => '',
        sort_order => 430,
        table_name => '',
        column_name => 'leavesonroof',
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '3', '', null);

    -- ***************************************************
    -- vacantorseasonal

    acs_attribute.drop_attribute ('df_qbe_brush','vacantorseasonal');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'vacantorseasonal',
        datatype => 'enumeration',
        pretty_name => 'Is property vacant or a seasonal dwelling?',
        pretty_plural => 'Is property vacant or a seasonal dwelling?',
        default_value => '',
        sort_order => 440,
        table_name => '',
        column_name => 'vacantorseasonal',
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- poorupkeep

    acs_attribute.drop_attribute ('df_qbe_brush','poorupkeep');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'poorupkeep',
        datatype => 'enumeration',
        pretty_name => 'Any visible poor upkeep of house or premises?',
        pretty_plural => 'Any visible poor upkeep of house or premises?',
        default_value => '',
        sort_order => 450,
        table_name => '',
        column_name => 'poorupkeep',
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
	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''YES''', v_attribute_id, v_attribute_id, '11', '', null);

    -- ***************************************************
    -- groupby6

    acs_attribute.drop_attribute ('df_qbe_brush','groupby6');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'groupby6',
        datatype => 'groupby',
        pretty_name => 'REMARKS',
        pretty_plural => 'REMARKS',
        default_value => '',
        sort_order => 460,
        table_name => '',
        column_name => 'groupby6',
        min_n_values => 0,
        max_n_values => 1
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- additionalcomments

    acs_attribute.drop_attribute ('df_qbe_brush','additionalcomments');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_brush',
        attribute_name => 'additionalcomments',
        datatype => 'explain',
        pretty_name => 'Comments',
        pretty_plural => 'Comments',
        default_value => '',
        sort_order => 470,
        table_name => '',
        column_name => 'additionalcomments',
        min_n_values => 0,
        max_n_values => 4000
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

delete dform_array_names where object_type = 'df_qbe_brush';

insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/groupby1','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/interview','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/interviewname','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/occupancy','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/groupby2','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/dwellingtype','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/dwellingage','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/stories','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/construction','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/exteriorwalls','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/exteriorwallsother','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/rooftype','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/groupby3','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/withincitylimits','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/roofwoodtreated','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/roofsprinklered','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/chimneysparkarrestor','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/groupby4','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/twoaccessroutes','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/pavedaccess','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/homevisible','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/windingstreet','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/deadendstreet','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/groupby5','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/northbrushdist','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/northbrushtype','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/northbrushslope','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/southbrushdist','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/southbrushtype','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/southbrushslope','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/eastbrushdist','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/eastbrushtype','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/eastbrushslope','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/westbrushdist','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/westbrushtype','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/westbrushslope','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/vegetationdensity','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/vegetationcleared','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/landscapedensity','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/openfoundation','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/brushunderhouse','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/overhangingtrees','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/leavesonroof','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/vacantorseasonal','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/poorupkeep','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/groupby6','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_brush', '/df_qbe_brush/additionalcomments','dformv3');

commit;
-- build attributes
begin
    for rec in (select attribute_id
                from acs_attributes
                where object_type = 'df_qbe_brush') loop
        build_attr_path(rec.attribute_id, rec.attribute_id, '');
    end loop;
end;
/

commit;
