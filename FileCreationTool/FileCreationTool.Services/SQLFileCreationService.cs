using FileCreationTool.Services.Contracts;
using System;
using System.IO;
using System.Text;

namespace FileCreationTool.Services
{
    public class SQLFileCreationService : ISQLFileCreationService
    {
        public void CreateSQLFile(string filePath, StringBuilder sb, string company, string table)
        {
            string fileName = $@"{filePath}\df_{company}_{table}.sql";

            try
            {
                // Check if file already exists. If yes, delete it. 
                if (File.Exists(fileName))
                {
                    File.Delete(fileName);
                }

                // Create a new file 
                using (FileStream fs = File.Create(fileName))
                {
                    // Add some text to file
                    Byte[] title = new UTF8Encoding(true).GetBytes(sb.ToString());
                    fs.Write(title, 0, title.Length);
                }
            }
            catch (Exception Ex)
            {
                Console.WriteLine(Ex.ToString());
            }
        }
    }
}
