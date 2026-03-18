package sena.adso.biblioteca.util;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author USER
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDB {
    // Datos de acceso que definiste en tu proyecto [cite: 165, 167]
    private static final String URL = "jdbc:mysql://localhost:3306/biblioteca_db?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = "1057585950"; // Aquí pones tu clave real

    // Método para obtener la conexión [cite: 166]
    public static Connection getConnection() throws SQLException {
        // DriverManager busca el Driver y abre la conexión [cite: 170]
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
