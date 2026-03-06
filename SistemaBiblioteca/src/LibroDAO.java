/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author USER
 */
import java.sql.*; // Importamos las herramientas de SQL
import java.util.ArrayList; // Para guardar la lista de libros
import java.util.List;

public class LibroDAO {

    // Método para listar libros usando la VISTA que creamos en MySQL
    public List<Libro> listarLibros() {
        List<Libro> lista = new ArrayList<>();
        String sql = "SELECT * FROM vw_libros_detallados"; // Usamos tu vista

        try (Connection con = ConexionDB.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Libro l = new Libro();
                l.setIdLibro(rs.getInt("id_libro"));
                l.setTitulo(rs.getString("titulo"));
                // El campo 'disponible' en MySQL es tinyint, en Java es boolean
                l.setDisponible(rs.getBoolean("disponible"));
                lista.add(l);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar: " + e.getMessage());
        }
        return lista;
    }

    public boolean insertarLibro(Libro libro) {
        // La consulta SQL con signos de interrogación (?) como comodines
        String sql = "INSERT INTO libro (titulo, isbn, anio_publicacion, num_paginas, id_editorial, id_categoria, disponible) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionDB.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            // Asignamos los valores a los signos de interrogación
            ps.setString(1, libro.getTitulo());
            ps.setString(2, libro.getIsbn());
            ps.setInt(3, libro.getAnioPublicacion());
            ps.setInt(4, 300); // Valor por defecto para el ejemplo
            ps.setInt(5, 1);   // Editorial por defecto (asegúrate de que el ID 1 exista)
            ps.setInt(6, 1);   // Categoría por defecto
            ps.setBoolean(7, true);

            // Ejecutamos la inserción
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            System.out.println("Error al insertar libro: " + e.getMessage());
            return false;
        }
    }
    // MÉTODO PARA ACTUALIZAR (UPDATE)

    public boolean actualizarLibro(Libro libro) {
        String sql = "UPDATE libro SET titulo = ?, isbn = ?, anio_publicacion = ? WHERE id_libro = ?";

        try (Connection con = ConexionDB.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, libro.getTitulo());
            ps.setString(2, libro.getIsbn());
            ps.setInt(3, libro.getAnioPublicacion());
            ps.setInt(4, libro.getIdLibro()); // Usamos el ID para saber cuál actualizar

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar: " + e.getMessage());
            return false;
        }
    }

// MÉTODO PARA ELIMINAR (DELETE)
    public boolean eliminarLibro(int idLibro) {
        String sql = "DELETE FROM libro WHERE id_libro = ?";

        try (Connection con = ConexionDB.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idLibro);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar: " + e.getMessage());
            return false;
        }
    }

}
