using System;
using System.Data;
using System.Data.SqlClient;
using System.Threading;

class Program
{
    

    static void Main()
    {
        bool openDoor = false;

        while (true)
        {
            Console.Clear();
            Console.WriteLine("Scan RFID tag:");
            string userInput = Console.ReadLine();            
            openDoor = AccessGranted(userInput);

            if (openDoor)
            {
                AddLoggingData(userInput);
            }
            else
            {
                AddUnauthorizedAttempt(userInput);
            }
            System.Threading.Thread.Sleep(2000);
        }
        
    }
    


    public static void AddLoggingData(string userInput)
    {
        string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=RFID;Integrated Security=True";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("uspAddLoggingData", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@RfidValue", userInput);

                connection.Open();
                cmd.ExecuteNonQuery();
            }

        }                      
        
    }

    public static void AddUnauthorizedAttempt(string userInput)
    {
        string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=RFID;Integrated Security=True";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("uspAddUnauthorized", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@RfidValue", userInput);

                connection.Open();
                cmd.ExecuteNonQuery();
            }

        }

    }


    private static bool AccessGranted(string rfid)
    {

        string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=RFID;Integrated Security=True";

        bool access = false;
        List<string> rfidCollection = new List<string>();
        
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT ChipId FROM RFIDUSER";

            SqlCommand command = new SqlCommand(query, connection);

            connection.Open();

            SqlDataReader reader = command.ExecuteReader();

            while (reader.Read())
            {
                rfidCollection.Add(reader["ChipId"].ToString());
            }

            reader.Close();
        }
               
        foreach (var sqlRfid in rfidCollection)
        {
            if (rfid == sqlRfid)
            {                
                access = true;
                break;                
            }
            
        }              
        
        if (access)
        {
            Console.WriteLine("Du har tilgang");
        }
        else
        {
            Console.WriteLine("Adgang nektet");
        }


        return access;
    }
      



}
