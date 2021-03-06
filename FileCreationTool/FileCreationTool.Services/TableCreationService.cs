﻿using FileCreationTool.Models;
using FileCreationTool.Services.Contracts;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FileCreationTool.Services
{
    public class TableCreationService : ITableCreationService
    {
        public string CreateTableSQL(string filePath, IList<dynamic> data, CompanyModel companyModel)
        {
            try
            {
                var company = companyModel.CompanyName;
                var table = companyModel.TableName;

                var companyFirstToUpper = company.First().ToString().ToUpper() + company.Substring(1);
                var tableFirstToUpper = table.First().ToString().ToUpper() + table.Substring(1);

                var sb = new StringBuilder();

                sb.AppendLine($"drop table df_{company}_{table}s purge;\n");
                sb.AppendLine($"create table df_{company}_{table}s (");
                sb.AppendLine($"    {"object_id".PadRight(30)}    number constraint df_{company}_{table}_nn not null,");

                for (int i = 1; i < data.Count(); i++)
                {
                    var row = data[i];

                    var oraDataLength = (!string.IsNullOrEmpty(row[9].ToString()) ? row[9] : 100);

                    if (!string.IsNullOrEmpty(row[6].ToString()))
                    {
                        sb.AppendLine($"    {row[6].ToString().PadRight(30)}    varchar2({oraDataLength}),");
                    }
                }

                sb.AppendLine($"    constraint df_{company}_{table}_pk primary key (object_id),");
                sb.AppendLine($"    constraint df_{company}_{table}_fk foreign key (object_id) references acs_objects(object_id)");
                sb.AppendLine(");");
                sb.AppendLine();
                sb.AppendLine("begin");
                sb.AppendLine($"    acs_object_type.drop_type ('df_{company}_{table}','t');");
                sb.AppendLine($"    acs_object_type.create_type (");
                sb.AppendLine($"            object_type => 'df_{company}_{table}',");
                sb.AppendLine($"            pretty_name => '{tableFirstToUpper}',");
                sb.AppendLine($"            pretty_plural => '{tableFirstToUpper}',");
                sb.AppendLine($"            supertype => 'form_abstract',");
                sb.AppendLine($"            table_name => 'df_{company}_{table}s',");
                sb.AppendLine($"            id_column => 'object_id',");
                sb.AppendLine($"            package_name => 'df_{company}_{table}',");
                sb.AppendLine($"            abstract_p => 'f',");
                sb.AppendLine($"            type_extension_table => '',");
                sb.AppendLine($"            name_method => '',");
                sb.AppendLine($"            dynamic_p => 'f',");
                sb.AppendLine($"            getxml_p => 'f'");
                sb.AppendLine($"    );");
                sb.AppendLine($"end;");
                sb.AppendLine($"/");
                sb.AppendLine($"show errors;");
                sb.AppendLine();
                sb.AppendLine();
                sb.AppendLine($"declare");
                sb.AppendLine($"    v_attribute_id     number;");
                sb.AppendLine($"    v_enum_id          number;");
                sb.AppendLine($"    v_hazard_rule_id   number;");
                sb.AppendLine($"    v_company_id       number;");
                sb.AppendLine($"    v_creator_id       number;");
                sb.AppendLine($"    v_result           varchar2(100);");
                sb.AppendLine($"begin");
                sb.AppendLine($"    select object_id into v_company_id from site_nodes where surl = '/EMI/{companyFirstToUpper}/';");
                sb.AppendLine();
                sb.AppendLine($"    select party_id into v_creator_id from parties where email = 'admin@myriad-development.com';");
                sb.AppendLine($"    v_hazard_rule_id := hazard_rule.new(i_company_id => v_company_id, i_description => 'Initial', i_effective_date => sysdate, i_creator_id => v_creator_id, i_hzd_weight_threshold => 11, i_hzd_count_threshold => 0);");
                sb.AppendLine($"    delete from rules_hazard_attributes where hazard_rule_id = v_hazard_rule_id and attribute_id not in (select attribute_id from acs_attributes);");
                sb.AppendLine();

                int groupCount = 1;

                for (int i = 1; i < data.Count; i++)
                {
                    var row = data[i];
                    var prettyName = row[0].ToString().Trim();
                    var defaultValue = row[5];
                    var attribute = row[6].ToString().Trim();
                    var requiredInput = (row[7].ToString().ToLower()) == "yes" ? 't' : 'f';
                    var dataType = row[10];
                    var minValue = row[11];
                    var maxValue = row[12];

                    if (string.IsNullOrEmpty(attribute))  // check if this is a group
                    {
                        attribute = $"groupby{groupCount++}";
                        dataType = "groupby";
                        minValue = 0;
                        maxValue = 1;
                    }

                    sb.AppendLine();
                    sb.AppendLine("    -- ***************************************************");
                    sb.AppendLine($"    -- {attribute}");
                    sb.AppendLine();
                    sb.AppendLine($"    acs_attribute.drop_attribute ('df_{company}_{table}','{attribute}');");
                    sb.AppendLine();
                    sb.AppendLine($"    v_attribute_id := acs_attribute.create_attribute (");
                    sb.AppendLine($"        object_type => 'df_{company}_{table}',");
                    sb.AppendLine($"        attribute_name => '{attribute}',");
                    sb.AppendLine($"        datatype => '{dataType}',");
                    sb.AppendLine($"        pretty_name => '{prettyName}',");
                    sb.AppendLine($"        pretty_plural => '{prettyName}',");
                    sb.AppendLine($"        default_value => '{defaultValue}',");
                    sb.AppendLine($"        sort_order => {i * 10},");
                    sb.AppendLine($"        table_name => '',");
                    sb.AppendLine($"        column_name => '{attribute}',");
                    sb.AppendLine($"        min_n_values => {minValue},");
                    sb.AppendLine($"        max_n_values => {maxValue}");
                    sb.AppendLine($"    );");
                    sb.AppendLine();
                    sb.AppendLine($"    insert into display_attributes");
                    sb.AppendLine($"        (attribute_id, widget, sketch_p, required_p)");
                    sb.AppendLine($"    values");
                    sb.AppendLine($"        (v_attribute_id, 'simple', 'f', '{requiredInput}');");


                    if (!attribute.Contains("group"))
                    {
                        if (dataType.StringCellValue == "enumeration")
                        {
                            var enums = row[13].StringCellValue.Split(";", StringSplitOptions.RemoveEmptyEntries);
                            var enumsDispl = row[14].StringCellValue.Split(";", StringSplitOptions.RemoveEmptyEntries);

                            for (int j = 0; j < enums.Length; j++)
                            {
                                sb.AppendLine();
                                sb.AppendLine("    -- Enumeration Value");
                                sb.AppendLine("    select enum_seq.nextval into v_enum_id from dual;");
                                sb.AppendLine();
                                sb.AppendLine($"    insert into acs_enum_values");
                                sb.AppendLine($"        (attribute_id, enum_value, pretty_name, sort_order, enum_id)");
                                sb.AppendLine($"    values");
                                sb.AppendLine($"        (v_attribute_id, '{enums[j].ToString().Replace("-", "").Trim()}', '{enumsDispl[j].ToString().Trim()}', {(j + 1) * 10}, v_enum_id);");
                                sb.AppendLine();
                                sb.AppendLine($"    insert into display_enum_values");
                                sb.AppendLine($"        (attribute_id, enum_value, pretty_name, sort_order, visible_p, abbv_name, color, enum_id)");
                                sb.AppendLine($"    values");
                                sb.AppendLine($"        (v_attribute_id, '{enums[j].ToString().Replace("-", "").Trim()}', '{enumsDispl[j].ToString().Trim()}', {(j + 1) * 10}, 't', '', '', v_enum_id);");
                            }

                            // THE HAZARD MUST CONTAIN THE - (DASH SYMBOL) IN THE TEMPLATE (ENUMERATION) values -- thats  COLUMN 14(row[13] in this case)
                            var hazardWeights = row[2].ToString().Split(new[] { "\r\n", "\r", "\n" }, StringSplitOptions.RemoveEmptyEntries);

                            if (hazardWeights.Length > 0)
                            {
                                sb.AppendLine();
                                sb.AppendLine("    -- Hazards");
                                var hazards = row[13].StringCellValue.Split(";", StringSplitOptions.RemoveEmptyEntries);
                                //var hazardWeights= row[2].StringCellValue.Split(" ", StringSplitOptions.RemoveEmptyEntries);
                                var hazardCount = 0;

                                foreach (var hazard in hazards)
                                {

                                    if (hazard.Contains("-")) // THE HAZARD MUST CONTAIN THE - (DASH SYMBOL) IN THE TEMPLATE (ENUMERATION) values -- thats  COLUMN 14(row[13] in this case)
                                    {
                                        var hazardToUp = hazard.Replace("-", "").ToUpper().Trim();
                                        sb.AppendLine($"	v_result := hazard_rule.add_hazard(v_hazard_rule_id, v_attribute_id, ':1 = ''{hazardToUp}''', v_attribute_id, v_attribute_id, '{hazardWeights[hazardCount++]}', '', null);");
                                    }
                                }
                            }
                        }
                    }
                }

                sb.AppendLine();
                sb.AppendLine($"    v_result := hazard_rule.set_enabled(v_hazard_rule_id);");
                sb.AppendLine($"    commit;");
                sb.AppendLine($"end;");
                sb.AppendLine($"/");
                sb.AppendLine($"show errors;");
                sb.AppendLine();
                sb.AppendLine($"delete dform_array_names where object_type = 'df_{company}_{table}';");
                sb.AppendLine();

                groupCount = 1;

                for (int k = 1; k < data.Count(); k++)
                {
                    var row = data[k];
                    var attribute = row[6].ToString().Trim();

                    if (string.IsNullOrEmpty(attribute))
                    {
                        attribute = $"groupby{groupCount++}";
                    }

                    sb.AppendLine($"insert into dform_array_names (object_type, name, form_version) values ('df_{company}_{table}', '/df_{company}_{table}/{attribute}','dformv3');");
                }

                sb.AppendLine();
                sb.AppendLine($"commit;");
                sb.AppendLine($"-- build attributes");
                sb.AppendLine($"begin");
                sb.AppendLine($"    for rec in (select attribute_id");
                sb.AppendLine($"                from acs_attributes");
                sb.AppendLine($"                where object_type = 'df_{company}_{table}') loop");
                sb.AppendLine($"        build_attr_path(rec.attribute_id, rec.attribute_id, '');");
                sb.AppendLine($"    end loop;");
                sb.AppendLine($"end;");
                sb.AppendLine($"/");
                sb.AppendLine();
                sb.AppendLine($"commit;");

                return sb.ToString();
            }
            catch (Exception ex)
            {
                throw new ArgumentException($"The table cannot be crated. {ex.ToString()}");
            }
        }
    }
}
