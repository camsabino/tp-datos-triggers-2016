﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ClinicaFrba
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
            cargarRolesHabilitados();
        }

        protected int validar(string usuario, string contrasena, string rol)
        {
            using (SqlConnection conn = new SqlConnection(conexion.cadena))
            {
                conn.Open();
                SqlCommand command = new SqlCommand("LOS_TRIGGERS.usuario_login", conn);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@user_name", usuario);
                command.Parameters.AddWithValue("@user_password", contrasena);
                command.Parameters.AddWithValue("@rol", rol);

                SqlParameter paramRetorno = new SqlParameter("@resultado", SqlDbType.Int);
                paramRetorno.Direction = ParameterDirection.Output;
                command.Parameters.Add(paramRetorno);

                command.ExecuteNonQuery();
                int resultado = Convert.ToInt32(command.Parameters["@resultado"].Value);
                conn.Close();
                return resultado;
            }
        }

        protected void cargarRolesHabilitados()
        {
            c_rol.DataSource = usuario.traerRolesHabilitados();
        }

        private void b_ingresar_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(t_usuario.Text) && !string.IsNullOrEmpty(t_contrasena.Text)
                && !string.IsNullOrEmpty(c_rol.Text))
            {
                int resultado = validar(t_usuario.Text, t_contrasena.Text, c_rol.Text);

                if (resultado == 4)
                {
                    MessageBox.Show("El usuario: " + t_usuario.Text + " no pertenece al sistema.",
                        "Login incorrecto", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
                else if (resultado == 3)
                {
                    MessageBox.Show("El usuario: " + t_usuario.Text + " no tiene asignado el rol " + c_rol.Text + ".",
                        "Login incorrecto", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
                else if (resultado == 0)
                {
                    usuario.nombre_usuario = t_usuario.Text;
                    usuario.rol = c_rol.Text;
                    usuario.id_rol = usuario.traer_id_rol(t_usuario.Text, c_rol.Text);
                    MessageBox.Show("Ha ingresado satisfactoriamente al sistema como " + c_rol.Text + ".", "Login correcto.",
                        MessageBoxButtons.OK, MessageBoxIcon.Information);
                    Menu m1 = new Menu();
                    this.Hide();
                    m1.ShowDialog();
                }
                else if (resultado == 2) MessageBox.Show("Ha excedido la cantidad de intentos fallidos de Login. Su cuenta ha sido inhabilitada.",
                    "Login incorrecto", MessageBoxButtons.OK, MessageBoxIcon.Error);
                else if (resultado == 1)
                {
                    int intentosFallidos;
                    SqlConnection conexionBase = new SqlConnection(ClinicaFrba.conexion.cadena);
                    using (conexionBase)
                    {
                        conexionBase.Open();
                        SqlCommand comando = new SqlCommand("select user_intentos_fallidos_login from LOS_TRIGGERS.Usuario " +
                                                            "where user_name = @user_name", conexionBase);
                        comando.Parameters.AddWithValue("@user_name", t_usuario.Text);

                        SqlDataReader reader = comando.ExecuteReader();
                        reader.Read();
                        intentosFallidos = (int)reader.GetDecimal(0);
                        conexionBase.Close();
                    }
                    MessageBox.Show("La contraseña ingresada es inválida, intenténtelo nuevamente.\nCantidad de intentos restantes: " + (3 - intentosFallidos).ToString(),
                    "Login incorrecto", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            else MessageBox.Show("Por favor, complete todos los campos requeridos para el Login.", "No se han completado todos los campos",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        protected override void OnFormClosing(FormClosingEventArgs e)
        {
            base.OnFormClosing(e);
            if (e.CloseReason == CloseReason.WindowsShutDown) return;
            Application.Exit();
        }
    }
}
