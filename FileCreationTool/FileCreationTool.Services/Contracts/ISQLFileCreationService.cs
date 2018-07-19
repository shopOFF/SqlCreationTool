using System.Text;

namespace FileCreationTool.Services.Contracts
{
    public interface ISQLFileCreationService
    {
        void CreateSQLFile(string filePath, StringBuilder sb, string company, string table);
    }
}
