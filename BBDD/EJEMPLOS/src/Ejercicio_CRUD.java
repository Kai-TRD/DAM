import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Ejercicio_CRUD {
      static Scanner sc = new Scanner(System.in);

      public static void main(String[] args) {
            System.setProperty("jdbc.drivers", "com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/people";
            String user = "kailuo";
            String pass = "kailuo";
            try {
                  Connection connection = DriverManager.getConnection(url, user, pass);
                  System.out.println("Conexión a la base de datos OK.");
                  boolean fin_bucle = false;
                  do {
                        mostrarMenu();
                        int opcion = sc.nextInt();
                        switch (opcion) {
                              case 1:
                                    consultar_Cliente(connection);
                                    break;
                              case 2:
                                    dar_de_alta_Cliente(connection);
                                    break;
                              case 3:
                                    dar_de_baja_Cliente(connection);
                                    break;
                              case 4:
                                    modificar_Cliente(connection);
                                    break;
                              case 0:
                                    fin_bucle = true;
                                    break;
                              default:
                                    System.out.println("Indique una opción entre [0 - 4]");
                        }
                  } while (!fin_bucle);
                  connection.close();
                  System.out.println("Connection closed.");
            } catch (SQLException sqle) {
                  System.out.println(sqle.getMessage());
            }
      }

      private static void mostrarMenu() {
            String menu = "+-----MENU-----+";
            menu += "\n 1. Consultar cliente";
            menu += "\n 2. Dar alta a cliente";
            menu += "\n 3. Dar baja a cliente";
            menu += "\n 4. Modificar cliente";
            menu += "\n 0. Salir";
            System.out.println(menu);
      }

      public static void consultar_Cliente(Connection connection) {
            try {
                  String sql = "SELECT * FROM people";
                  PreparedStatement preparedStatement = connection.prepareStatement(sql);

                  ResultSet resultSet = preparedStatement.executeQuery();

                  while (resultSet.next()) {
                        String dni = resultSet.getString("dni");
                        String nombre = resultSet.getString("nombre");
                        String apellidos = resultSet.getString("apellidos");
                        String telefono = resultSet.getString("telefono");

                        System.out.println("DNI: " + dni);
                        System.out.println("Nombre: " + nombre);
                        System.out.println("Apellidos: " + apellidos);
                        System.out.println("Teléfono: " + telefono);
                        System.out.println("---------------------");
                  }

                  resultSet.close();
                  preparedStatement.close();
            } catch (SQLException e) {
                  System.out.println("Error al mostrar las personas: " + e.getMessage());
            }
            sc.nextLine();
            
      }

      public static void modificar_Cliente(Connection connection) throws SQLException {
            sc.nextLine();
            System.out.print("Introduce el DNI del cliente a modificar: ");
            String dni = sc.nextLine();
    
            System.out.print("Introduce el nuevo nombre del cliente: ");
            String nombre = sc.nextLine();
    
            System.out.print("Introduce los nuevos apellidos del cliente: ");
            String apellidos = sc.nextLine();
    
            System.out.print("Introduce el nuevo teléfono del cliente: ");
            String telefono = sc.nextLine();
    
            String query = "UPDATE people SET nombre = ?, apellidos = ?, telefono = ? WHERE dni = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, nombre);
            statement.setString(2, apellidos);
            statement.setString(3, telefono);
            statement.setString(4, dni);
    
            int filasActualizadas = statement.executeUpdate();
            if (filasActualizadas > 0) {
                System.out.println("Cliente modificado correctamente.");
            } else {
                System.out.println("No se encontró ningún cliente con el DNI proporcionado.");
            }
    
            statement.close();
            
        }

      public static void dar_de_baja_Cliente(Connection connection) {

            sc.nextLine();
            System.out.print("DNI: ");
            String dni = sc.nextLine();

            try {
                  String sql = "DELETE FROM people WHERE dni = ?";
                  PreparedStatement preparedStatement = connection.prepareStatement(sql);
                  preparedStatement.setString(1, dni);

                  int filasAfectadas = preparedStatement.executeUpdate();
                  if (filasAfectadas > 0) {
                        System.out.println("Persona eliminada exitosamente.");
                  } else {
                        System.out.println("No se encontró una persona con el DNI ingresado.");
                  }

                  preparedStatement.close();
            } catch (SQLException e) {
                  System.out.println("Error al eliminar la persona: " + e.getMessage());
            }
            
      }

      public static void dar_de_alta_Cliente(Connection connection) {
            System.out.println("Ingrese los datos del cliente:");
            sc.nextLine();
            System.out.print("DNI: ");
            String dni = sc.nextLine();
            System.out.print("Nombre: ");
            String nombre = sc.nextLine();
            System.out.print("Apellidos: ");
            String apellidos = sc.nextLine();
            System.out.print("Teléfono: ");
            String telefono = sc.nextLine();

            try {
                  String sql = "INSERT INTO people (dni, nombre, apellidos, telefono) VALUES (?, ?, ?, ?)";
                  PreparedStatement statement = connection.prepareStatement(sql);
                  statement.setString(1, dni);
                  statement.setString(2, nombre);
                  statement.setString(3, apellidos);
                  statement.setString(4, telefono);

                  int filasAfectadas = statement.executeUpdate();
                  if (filasAfectadas > 0) {
                        System.out.println("Cliente dado de alta exitosamente.");
                  } else {
                        System.out.println("Error al dar de alta el cliente.");
                  }
            } catch (SQLException e) {
                  System.out.println("Error al dar de alta el cliente: " + e.getMessage());
            }
            
      }

      public static void limpiarConsola() {
            sc.nextLine();
            System.out.print("\033[H\033[2J");  
      }

}