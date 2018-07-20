using FileCreationTool.Models;
using FileCreationTool.Services.Contracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FileCreationTool.Services
{
    public class ValidationCreationService : IValidationCreationService
    {
        private readonly ISQLFileCreationService sQLFileCreationService;
        private IEnumerable<object> requiredSplit;

        public ValidationCreationService(ISQLFileCreationService sQLFileCreationService)
        {
            this.sQLFileCreationService = sQLFileCreationService;
        }

        public void CreateValidationSQL(string filePath, IList<dynamic> data, CompanyModel companyModel)
        {
            var company = companyModel.CompanyName.ToLower();
            var table = companyModel.TableName.ToLower();

            var sb = new StringBuilder();

            sb.AppendLine($"declare");
            sb.AppendLine($"    v_attribute_id     number;");
            sb.AppendLine($"begin");

            sb.AppendLine($"    delete validation_attributes where obj_attrs like '%df_{company}_{table}%';");

            for (int i = 1; i < data.Count; i++)
            {
                var row = data[i];
                var prettyName = row[0].ToString().Trim();
                var attribute = row[6].ToString().Trim();
                var requiredValidation = row[3].ToString();
                var dataType = row[10];
                var minValue = row[11];
                var maxValue = row[12];
                var enums = row[13].StringCellValue.Split(";", StringSplitOptions.RemoveEmptyEntries);
                var enumsDispl = row[14].StringCellValue.Split(";", StringSplitOptions.RemoveEmptyEntries);

                IList<dynamic> validationValues = requiredValidation.Split('"', StringSplitOptions.RemoveEmptyEntries);
                var validationValuesSplited = validationValues
                    .Where(x => !(x.Contains("Required if")) && !(x.Contains("is")) && !(x.Contains("and"))).ToList();


                if (validationValuesSplited.Count() > 1)
                {
                    sb.AppendLine();
                    sb.AppendLine($"    -- ***************************************************");
                    sb.AppendLine($"    -- {attribute}");
                    sb.AppendLine($"    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_{company}_{table}' and attribute_name = '{attribute}';");

                    for (int j = 0; j < validationValuesSplited.Count(); j += 2)
                    {
                        var fieldToCheck = validationValuesSplited[j];
                        var enumValue = validationValuesSplited[j + 1];
                        var fieldAttributeData = string.Empty;

                        for (int rows = 1; rows < data.Count; rows++)
                        {
                            var currentFiled = data[rows];
                            if (currentFiled[0].StringCellValue.ToLower().Contains(fieldToCheck.ToLower()))
                            {
                                fieldAttributeData = currentFiled[6].StringCellValue;
                                break;
                            }
                        }

                        sb.AppendLine($"    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_{company}_{table}.{fieldAttributeData}', '{enumValue.ToUpper()}', 'Is required when {fieldToCheck} is {enumValue}.');");
                    }
                }
            }

            sb.AppendLine();
            sb.AppendLine($"    commit;");
            sb.AppendLine($"end;");
            sb.AppendLine($"/");

            this.sQLFileCreationService.CreateSQLFile($@"{filePath}\GeneratedValidation", sb, company, $"{table}-validation");
        }
    }
}
