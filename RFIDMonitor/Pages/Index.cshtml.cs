using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace RFIDMonitor.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> logger;
        public List<LogData> LogDataList { get; set; }

        public IndexModel(ILogger<IndexModel> logger)
        {
            logger = logger;
            LogDataList = new List<LogData>();
        }

        public void OnGet()
        {
            string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=RFID;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string selectQuery = "SELECT * FROM LOGGING";

                using (SqlCommand command = new SqlCommand(selectQuery, connection))
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        LogDataList.Add(new LogData
                        {
                            RFIDID = reader.GetString(0),
                            ScannedDate = reader.GetDateTime(1)
                        });
                    }
                }
            }
        }
    }

    public class LogData
    {
        public string? RFIDID { get; set; }
        public DateTime ScannedDate { get; set; }
    }
}
