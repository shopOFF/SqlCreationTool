drop table df_hartford_historics purge;

create table df_hartford_historics (
    object_id                         number constraint df_hartford_historic_nn not null,
    insptype                          varchar2(100),
    insppgm                           varchar2(100),
    pilot                             varchar2(200),
    disposition                       varchar2(100),
    insprc                            varchar2(200),
    reviewuw                          varchar2(200),
    uwcomments                        varchar2(4000),
    vendor                            varchar2(100),
    constraint df_hartford_historic_pk primary key (object_id),
    constraint df_hartford_historic_fk foreign key (object_id) references acs_objects(object_id)
);

begin
    acs_object_type.drop_type ('df_hartford_historic','t');
    acs_object_type.create_type (
            object_type => 'df_hartford_historic',
            pretty_name => 'Historic',
            pretty_plural => 'Historic',
            supertype => 'form_abstract',
            table_name => 'df_hartford_historics',
            id_column => 'object_id',
            package_name => 'df_hartford_historic',
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
    -- insptype

    acs_attribute.drop_attribute ('df_hartford_historic','insptype');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_historic',
        attribute_name => 'insptype',
        datatype => 'enumeration',
        pretty_name => 'Inspection Type',
        pretty_plural => 'Inspection Type',
        default_value => '',
        sort_order => 10,
        table_name => '',
        column_name => 'insptype',
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
        (v_attribute_id, 'EXT', 'Exterior', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'EXT', 'Exterior', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'EXTC', 'Exterior with Calc', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'EXTC', 'Exterior with Calc', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'INTLVL1', 'Interior Level 1', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'INTLVL1', 'Interior Level 1', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'INTLVL2', 'Interior Level 2', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'INTLVL2', 'Interior Level 2', 40, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'INTLVL3', 'Interior Level 3', 50, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'INTLVL3', 'Interior Level 3', 50, 't', '', '', v_enum_id);

    -- ***************************************************
    -- insppgm

    acs_attribute.drop_attribute ('df_hartford_historic','insppgm');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_historic',
        attribute_name => 'insppgm',
        datatype => 'enumeration',
        pretty_name => 'Inspection Program',
        pretty_plural => 'Inspection Program',
        default_value => '',
        sort_order => 20,
        table_name => '',
        column_name => 'insppgm',
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
        (v_attribute_id, 'AGCYNB', 'Agency NB', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'AGCYNB', 'Agency NB', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'AARPNB', 'AARP NB', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'AARPNB', 'AARP NB', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'AGCYNBHV', 'Agency NB HV', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'AGCYNBHV', 'Agency NB HV', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'AARPNBHV', 'AARP NB HV', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'AARPNBHV', 'AARP NB HV', 40, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'AGCYINF', 'Agency INF', 50, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'AGCYINF', 'Agency INF', 50, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'AGCYHVINF', 'Agency HV INF', 60, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'AGCYHVINF', 'Agency HV INF', 60, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'AARPHVINF', 'AARP HV INF', 70, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'AARPHVINF', 'AARP HV INF', 70, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'AGCYOCC', 'Agency OCC', 80, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'AGCYOCC', 'Agency OCC', 80, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'AARPOCC', 'AARP OCC', 90, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'AARPOCC', 'AARP OCC', 90, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'AGCYNBEXTITV', 'Agency NB EXT ITV', 100, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'AGCYNBEXTITV', 'Agency NB EXT ITV', 100, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'AARPNBEXTITV', 'AARP NB EXT ITV', 110, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'AARPNBEXTITV', 'AARP NB EXT ITV', 110, 't', '', '', v_enum_id);

    -- ***************************************************
    -- pilot

    acs_attribute.drop_attribute ('df_hartford_historic','pilot');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_historic',
        attribute_name => 'pilot',
        datatype => 'string',
        pretty_name => 'Supp-Pilot',
        pretty_plural => 'Supp-Pilot',
        default_value => '',
        sort_order => 30,
        table_name => '',
        column_name => 'pilot',
        min_n_values => 1,
        max_n_values => 200
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- disposition

    acs_attribute.drop_attribute ('df_hartford_historic','disposition');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_historic',
        attribute_name => 'disposition',
        datatype => 'enumeration',
        pretty_name => 'Disposition',
        pretty_plural => 'Disposition',
        default_value => '',
        sort_order => 40,
        table_name => '',
        column_name => 'disposition',
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
        (v_attribute_id, 'NEWCU', '2015 NEW Cleanup', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NEWCU', '2015 NEW Cleanup', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'ATR', 'AGREE TO REVERSE DNOC/DNR', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'ATR', 'AGREE TO REVERSE DNOC/DNR', 20, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'CLEAN', 'COMPLETED - NO ACTION/CLEAN/WITHIN VARIANCE', 30, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'CLEAN', 'COMPLETED - NO ACTION/CLEAN/WITHIN VARIANCE', 30, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'DNOCDNR', 'DNOC/DNR', 40, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'DNOCDNR', 'DNOC/DNR', 40, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'NOALERT', 'NO ALERTS-NOT WORKED', 50, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'NOALERT', 'NO ALERTS-NOT WORKED', 50, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'PENDCOMO', 'PEND COMPLETED - Other', 60, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'PENDCOMO', 'PEND COMPLETED - Other', 60, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'PENDCOMRM', 'PEND COMPLETED - Repairs made', 70, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'PENDCOMRM', 'PEND COMPLETED - Repairs made', 70, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'OI', 'OVERINSURED', 80, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'OI', 'OVERINSURED', 80, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'UI', 'UNDERINSURED', 90, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'UI', 'UNDERINSURED', 90, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'PRC', 'POLICY RATING CORRECTION', 100, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'PRC', 'POLICY RATING CORRECTION', 100, 't', '', '', v_enum_id);

    -- ***************************************************
    -- insprc

    acs_attribute.drop_attribute ('df_hartford_historic','insprc');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_historic',
        attribute_name => 'insprc',
        datatype => 'string',
        pretty_name => 'Inspection RC',
        pretty_plural => 'Inspection RC',
        default_value => '',
        sort_order => 50,
        table_name => '',
        column_name => 'insprc',
        min_n_values => 1,
        max_n_values => 200
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- reviewuw

    acs_attribute.drop_attribute ('df_hartford_historic','reviewuw');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_historic',
        attribute_name => 'reviewuw',
        datatype => 'string',
        pretty_name => 'Reviewing UW',
        pretty_plural => 'Reviewing UW',
        default_value => '',
        sort_order => 60,
        table_name => '',
        column_name => 'reviewuw',
        min_n_values => 1,
        max_n_values => 200
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- uwcomments

    acs_attribute.drop_attribute ('df_hartford_historic','uwcomments');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_historic',
        attribute_name => 'uwcomments',
        datatype => 'string',
        pretty_name => 'UW Comments',
        pretty_plural => 'UW Comments',
        default_value => '',
        sort_order => 70,
        table_name => '',
        column_name => 'uwcomments',
        min_n_values => 1,
        max_n_values => 4000
    );

    insert into display_attributes
        (attribute_id, widget, sketch_p, required_p)
    values
        (v_attribute_id, 'simple', 'f', 'f');

    -- ***************************************************
    -- vendor

    acs_attribute.drop_attribute ('df_hartford_historic','vendor');

    v_attribute_id := acs_attribute.create_attribute (
        object_type => 'df_hartford_historic',
        attribute_name => 'vendor',
        datatype => 'enumeration',
        pretty_name => 'Vendor',
        pretty_plural => 'Vendor',
        default_value => '',
        sort_order => 80,
        table_name => '',
        column_name => 'vendor',
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
        (v_attribute_id, 'CASTLE', 'CASTLE', 10, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'CASTLE', 'CASTLE', 10, 't', '', '', v_enum_id);

    -- Enumeration Value
    select enum_seq.nextval into v_enum_id from dual;

    insert into acs_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, enum_id)
    values
        (v_attribute_id, 'IPI', 'IPI', 20, v_enum_id);

    insert into display_enum_values
        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)
    values
        (v_attribute_id, 'IPI', 'IPI', 20, 't', '', '', v_enum_id);

    v_result := hazard_rule.set_enabled(v_hazard_rule_id);
    commit;
end;
/
show errors;

delete dform_array_names where object_type = 'df_hartford_historic';

insert into dform_array_names (object_type, name, form_version) values ('df_hartford_historic', '/df_hartford_historic/insptype','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_historic', '/df_hartford_historic/insppgm','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_historic', '/df_hartford_historic/pilot','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_historic', '/df_hartford_historic/disposition','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_historic', '/df_hartford_historic/insprc','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_historic', '/df_hartford_historic/reviewuw','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_historic', '/df_hartford_historic/uwcomments','dformv3');
insert into dform_array_names (object_type, name, form_version) values ('df_hartford_historic', '/df_hartford_historic/vendor','dformv3');

commit;
-- build attributes
begin
    for rec in (select attribute_id
                from acs_attributes
                where object_type = 'df_hartford_historic') loop
        build_attr_path(rec.attribute_id, rec.attribute_id, '');
    end loop;
end;
/

commit;
