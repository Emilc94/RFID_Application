//using Microsoft.AspNetCore.Mvc;
//using System;
//using System.Data;
//using System.Data.SqlClient;

//public class HomeController : Controller
//{
//    private string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=RFID;Integrated Security=True";

//    public IActionResult Index()
//    {
//        ViewData["TableData"] = GetTableData();
//        return View();
//    }

//    private DataTable GetTableData()
//    {
//        DataTable table = new DataTable();

//        using (SqlConnection connection = new SqlConnection(connectionString))
//        {
//            connection.Open();

//            string selectQuery = "SELECT * FROM LOGGING";

//            using (SqlCommand selectCmd = new SqlCommand(selectQuery, connection))
//            using (SqlDataAdapter adapter = new SqlDataAdapter(selectCmd))
//            {
//                adapter.Fill(table);
//            }
//        }

//        return table;
//    }
//}
