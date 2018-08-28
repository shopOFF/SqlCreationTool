using System.Text;

namespace FileCreationTool.Services.Contracts
{
    public interface ISQLFileCreationService
    {
        void CreateSQLFile(string filePath, string stringSQL, string company, string table);
    }
}
