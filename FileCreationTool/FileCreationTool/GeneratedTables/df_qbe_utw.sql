drop table df_qbe_utws purge;

create table df_qbe_utws (
    object_id                         number constraint df_qbe_utw_nn not null,
    status                            varchar2(100),
    agent1time                        date,
    agent1result                      varchar2(100),
    agent2time                        date,
    agent2result                      varchar2(100),
    insured1time                      date,
    insured1result                    varchar2(100),
    comments                          varchar2(3800),
    constraint df_qbe_utw_pk primary key (object_id),
    constraint df_qbe_utw_fk foreign key (object_id) references acs_objects(object_id)
);

begin
    acs_object_type.drop_type ('df_qbe_utw','t');
    acs_object_type.create_type (
            object_type => 'df_qbe_utw',
            pretty_name => 'Unable to Work',
            pretty_plural => 'Unable to Work',
            supertype => 'form_abstract',
            table_name => 'df_qbe_utws',
            id_column => 'object_id',
            package_name => 'df_qbe_utw',
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
    -- status

    acs_attribute.drop_attribute ('df_qbe_utw','status');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_utw',
        attribute_name => 'status',
        datatype => 'enumeration',
        pretty_name => 'Reason for Unable to Work',
        pretty_plural => 'Reason for Unable to Work',
        default_value => '',
        sort_order => 10,
        table_name => '',
        column_name => 'status',
        min_n_values => 1,
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
        (v_attribute_id, 'UNMAP', 'Unable to Map/Locate', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UNMAP', 'Unable to Map/Locate', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'POLCAN', 'Policy Cancelled', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'POLCAN', 'Policy Cancelled', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UNANIMAL', 'Unable to Access - Animal', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UNANIMAL', 'Unable to Access - Animal', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UNGATED', 'Unable to Access - Gated', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UNGATED', 'Unable to Access - Gated', 40, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UNOTHER', 'Unable to Access – Other', 50, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UNOTHER', 'Unable to Access – Other', 50, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'REF', 'Policy Holder Refused Inspection', 60, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'REF', 'Policy Holder Refused Inspection', 60, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UNDCONSTR', 'Under Construction', 70, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UNDCONSTR', 'Under Construction', 70, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UNDIR', 'Agent Unable to Provide Directions', 80, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UNDIR', 'Agent Unable to Provide Directions', 80, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'OTHER', 'Other', 90, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'OTHER', 'Other', 90, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'DUP', 'Duplicate', 100, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'DUP', 'Duplicate', 100, 't', '', '', v_enum_id);

    -- ***************************************************
    -- agent1time

    acs_attribute.drop_attribute ('df_qbe_utw','agent1time');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_utw',
        attribute_name => 'agent1time',
        datatype => 'date',
        pretty_name => 'Agent Contact 1st Attempt Date and Time',
        pretty_plural => 'Agent Contact 1st Attempt Date and Time',
        default_value => '',
        sort_order => 20,
        table_name => '',
        column_name => 'agent1time',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- agent1result

    acs_attribute.drop_attribute ('df_qbe_utw','agent1result');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_utw',
        attribute_name => 'agent1result',
        datatype => 'string',
        pretty_name => 'Agent Contact 1st Attempt Result',
        pretty_plural => 'Agent Contact 1st Attempt Result',
        default_value => '',
        sort_order => 30,
        table_name => '',
        column_name => 'agent1result',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- agent2time

    acs_attribute.drop_attribute ('df_qbe_utw','agent2time');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_utw',
        attribute_name => 'agent2time',
        datatype => 'date',
        pretty_name => 'Agent Contact 2nd Attempt Date and Time',
        pretty_plural => 'Agent Contact 2nd Attempt Date and Time',
        default_value => '',
        sort_order => 40,
        table_name => '',
        column_name => 'agent2time',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- agent2result

    acs_attribute.drop_attribute ('df_qbe_utw','agent2result');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_utw',
        attribute_name => 'agent2result',
        datatype => 'string',
        pretty_name => 'Agent Contact 2nd Attempt Result',
        pretty_plural => 'Agent Contact 2nd Attempt Result',
        default_value => '',
        sort_order => 50,
        table_name => '',
        column_name => 'agent2result',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- insured1time

    acs_attribute.drop_attribute ('df_qbe_utw','insured1time');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_utw',
        attribute_name => 'insured1time',
        datatype => 'date',
        pretty_name => 'Insured Contact 1st Attempt Date and Time',
        pretty_plural => 'Insured Contact 1st Attempt Date and Time',
        default_value => '',
        sort_order => 60,
        table_name => '',
        column_name => 'insured1time',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- insured1result

    acs_attribute.drop_attribute ('df_qbe_utw','insured1result');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_utw',
        attribute_name => 'insured1result',
        datatype => 'string',
        pretty_name => 'Insured Contact Result',
        pretty_plural => 'Insured Contact Result',
        default_value => '',
        sort_order => 70,
        table_name => '',
        column_name => 'insured1result',
        min_n_values => 1,
        max_n_values => 100
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- comments

    acs_attribute.drop_attribute ('df_qbe_utw','comments');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_qbe_utw',
        attribute_name => 'comments',
        datatype => 'string',
        pretty_name => 'Comments',
        pretty_plural => 'Comments',
        default_value => '',
        sort_order => 80,
        table_name => '',
        column_name => 'comments',
        min_n_values => 1,
        max_n_values => 3800
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

delete dform_array_names where object_type = 'df_qbe_utw';

insert into dform_array_names (object_type, name, form_version) values ('df_qbe_utw', '/df_qbe_utw/status','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_utw', '/df_qbe_utw/agent1time','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_utw', '/df_qbe_utw/agent1result','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_utw', '/df_qbe_utw/agent2time','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_utw', '/df_qbe_utw/agent2result','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_utw', '/df_qbe_utw/insured1time','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_utw', '/df_qbe_utw/insured1result','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_qbe_utw', '/df_qbe_utw/comments','dformv3');

commit;
-- build attributes
begin
    for rec in (select attribute_id
                from acs_attributes
                where object_type = 'df_qbe_utw') loop
        build_attr_path(rec.attribute_id, rec.attribute_id, '');
    end loop;
end;
/

commit;
