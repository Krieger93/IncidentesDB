-- CREACION DE VISTAS
CREATE VIEW KPIBajaPuntuacion AS SELECT puntaje_usuario FROM kpis WHERE puntaje_usuario < 6;
CREATE VIEW TicketsSinResolver AS SELECT titulo_incidente, descripcion, estado FROM incidentes WHERE estado <> "Solved";
CREATE VIEW ContarUsuariosPorGrupos AS SELECT g.nombre_grupo, g.id_grupo,(SELECT COUNT(*) FROM usuarios WHERE id_grupo = g.id_grupo) UsuariosxGrupo FROM grupos g;
CREATE VIEW ContarTicketsPorCategorias AS SELECT c.id_categoria, c.titulo_categoria, (SELECT COUNT(*) FROM incidentes WHERE id_categoria = c.id_categoria) TicketsxCategoria FROM categorias c;
CREATE VIEW TicketsPorUserAsignado AS SELECT i.titulo_incidente, i.descripcion, i.estado, u.id_user, u.user FROM incidentes i INNER JOIN usuarios u ON i.id_owner = u.id_user;
