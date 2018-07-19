using FileCreationTool.Models;
using FileCreationTool.Services.Contracts;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace FileCreationTool.Services
{
    public class PackageCreationService : IPackageCreationService
    {
        private readonly ISQLFileCreationService sQLFileCreationService;

        public PackageCreationService(ISQLFileCreationService sQLFileCreationService)
        {
            this.sQLFileCreationService = sQLFileCreationService;
        }

        public void CreatePackagesSQL(string filePath, CompanyModel companyModel)
        {
            var company = companyModel.CompanyName.ToLower();
            var table = companyModel.TableName.ToLower();

            var sb = new StringBuilder();

            sb.AppendLine($"create or replace package df_{company}_{table}");
            sb.AppendLine($"is");
            sb.AppendLine($"    function new (");
            sb.AppendLine($"        object_id             in df_{company}_{table}s.object_id%TYPE default null,");
            sb.AppendLine($"        object_type           in acs_objects.object_type%TYPE default 'df_{company}_{table}',");
            sb.AppendLine($"        creation_date         in acs_objects.creation_date%TYPE default sysdate,");
            sb.AppendLine($"        creation_user         in acs_objects.creation_user%TYPE default null,");
            sb.AppendLine($"        creation_ip           in acs_objects.creation_ip%TYPE default null,");
            sb.AppendLine($"        context_id            in acs_objects.context_id%TYPE default null");
            sb.AppendLine($"    ) return df_{company}_{table}s.object_id%TYPE;");
            sb.AppendLine();
            sb.AppendLine($"    procedure delete (");
            sb.AppendLine($"        i_object_id in df_{company}_{table}s.object_id%TYPE");
            sb.AppendLine($"    );");
            sb.AppendLine();
            sb.AppendLine($"end df_{company}_{table};");
            sb.AppendLine($"/");
            sb.AppendLine($"show errors;");

            this.sQLFileCreationService.CreateSQLFile($@"{filePath}\GeneratedPackages\Packages", sb, company, table);
        }

        public void CreatePackageBodiesSQL(string filePath, CompanyModel companyModel)
        {
            var company = companyModel.CompanyName.ToLower();
            var table = companyModel.TableName.ToLower();
            var sb = new StringBuilder();

            sb.AppendLine($"create or replace package body df_{company}_{table}");
            sb.AppendLine($"is");
            sb.AppendLine($"    function new (");
            sb.AppendLine($"        object_id               in df_{company}_{table}s.object_id%TYPE default null,");
            sb.AppendLine($"        object_type             in acs_objects.object_type%TYPE default 'df_{company}_{table}',");
            sb.AppendLine($"        creation_date           in acs_objects.creation_date%TYPE default sysdate,");
            sb.AppendLine($"        creation_user           in acs_objects.creation_user%TYPE default null,");
            sb.AppendLine($"        creation_ip             in acs_objects.creation_ip%TYPE default null,");
            sb.AppendLine($"        context_id              in acs_objects.context_id%TYPE default null");
            sb.AppendLine($"    ) return df_{company}_{table}s.object_id%TYPE");
            sb.AppendLine($"    is");
            sb.AppendLine($"		v_object_id df_{company}_{table}s.object_id%TYPE;");
            sb.AppendLine($"    begin");
            sb.AppendLine($"		v_object_id := acs_object.new (");
            sb.AppendLine($"			object_id => object_id,");
            sb.AppendLine($"            object_type => object_type,");
            sb.AppendLine($"            creation_date => creation_date,");
            sb.AppendLine($"            creation_user => creation_user,");
            sb.AppendLine($"            creation_ip => creation_ip,");
            sb.AppendLine($"            context_id => context_id");
            sb.AppendLine($"        );");
            sb.AppendLine();
            sb.AppendLine($"        insert into df_{company}_{table}s");
            sb.AppendLine($"			(object_id)");
            sb.AppendLine($"        values");
            sb.AppendLine($"			(v_object_id); ");
            sb.AppendLine();
            sb.AppendLine($"        return v_object_id;");
            sb.AppendLine($"    end new;");
            sb.AppendLine();
            sb.AppendLine($"    procedure delete (");
            sb.AppendLine($"        i_object_id in df_{company}_{table}s.object_id%TYPE");
            sb.AppendLine($"    )");
            sb.AppendLine($"        is");
            sb.AppendLine($"            begin");
            sb.AppendLine($"                delete from df_{company}_{table}s");
            sb.AppendLine($"                where  object_id = i_object_id;");
            sb.AppendLine($"                acs_object.delete(i_object_id);");
            sb.AppendLine($"    end delete;");
            sb.AppendLine($"end df_{company}_{table};");
            sb.AppendLine($"/");
            sb.AppendLine($"show errors;");

            this.sQLFileCreationService.CreateSQLFile($@"{filePath}\GeneratedPackages\PackageBodies", sb, company, table);
        }
    }
}
