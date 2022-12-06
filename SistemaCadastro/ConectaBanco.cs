using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data;
using MySql.Data.MySqlClient;
using System.Data;

namespace SistemaCadastro
{
    internal class ConectaBanco
    {
        MySqlConnection conexao = new MySqlConnection("server=localhost;user id=root;password=;database=clinicaestetica");
        public String mensagem;
        public DataTable listaProcedimentos()
        {
            // comentario
            MySqlCommand cmd = new MySqlCommand("lista_procedimentos", conexao);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                conexao.Open();
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable tabela = new DataTable();
                da.Fill(tabela);
                return tabela;
            }// fim try
            catch (MySqlException e)
            {
                mensagem = "Erro:" + e.Message;
                return null;
            }
            finally
            {
                conexao.Close();
            }

        }// fim lista_procedimentos

        public DataTable listaConsultas()
        {
            MySqlCommand cmd = new MySqlCommand("lista_consultas", conexao);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                conexao.Open();
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable tabela = new DataTable();
                da.Fill(tabela);
                return tabela;
            }// fim try
            catch (MySqlException e)
            {
                mensagem = "Erro:" + e.Message;
                return null;
            }
            finally
            {
                conexao.Close();
            }

        }// fim lista_consulta



        public bool insereConsulta(Consulta c)
        {
            MySqlCommand cmd = new MySqlCommand("proc_insereConsulta", conexao);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("cliente", c.Cliente);
            cmd.Parameters.AddWithValue("cpf", c.Cpf);
            cmd.Parameters.AddWithValue("telefone",c.Telefone);
            cmd.Parameters.AddWithValue("hora", c.Hora);
            cmd.Parameters.AddWithValue("dataD", c.DataD);
            cmd.Parameters.AddWithValue("proce", c.Proce);
            try
            {
                conexao.Open();
                cmd.ExecuteNonQuery(); 
                return true;
            }
            catch (MySqlException e)
            {
                mensagem = "Erro:" + e.Message;
                return false;
            }
            finally
            {
                conexao.Close();
            }
        }// fim insereConsulta

        public bool insereProcedimento(String procedimento)
        {
            MySqlCommand cmd = new MySqlCommand("proc_insereProcedimento", conexao);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("nomeProcedimento", procedimento);
            try
            {
                conexao.Open();
                cmd.ExecuteNonQuery(); 
                return true;
            }
            catch (MySqlException e)
            {
                mensagem = "Erro:" + e.Message;
                return false;
            }
            finally
            {
                conexao.Close();
            }
        }// fim insereProcedimento

        public bool alteraConsulta(Consulta c, int idAlterar)
        {
            MySqlCommand cmd = new MySqlCommand("proc_alteraConsulta", conexao);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("idAlterar", idAlterar);
            cmd.Parameters.AddWithValue("cliente", c.Cliente);
            cmd.Parameters.AddWithValue("cpf", c.Cpf);
            cmd.Parameters.AddWithValue("telefone", c.Telefone);
            cmd.Parameters.AddWithValue("hora", c.Hora);
            cmd.Parameters.AddWithValue("dataD", c.DataD);
            cmd.Parameters.AddWithValue("proce", c.Proce);
            try
            {
                conexao.Open();
                cmd.ExecuteNonQuery();
                return true;
            }
            catch (MySqlException e)
            {
                mensagem = "Erro:" + e.Message;
                return false;
            }
            finally
            {
                conexao.Close();
            }
        }// fim alterarConsulta

        public bool deletaConsulta(int codConsulta)
        {
            MySqlCommand cmd = new MySqlCommand("proc_apagarConsulta", conexao);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("cod", codConsulta);
            try
            {
                conexao.Open();
                cmd.ExecuteNonQuery(); 
                return true;
            }
            catch (MySqlException e)
            {
                mensagem = "Erro:" + e.Message;
                return false;
            }
            finally
            {
                conexao.Close();
            }
        }// fim deletaConsulta

        public bool verifica(string user, string pass)
        {
            string senhaHash = Biblioteca.makeHash(pass);
            MySqlCommand cmd = new MySqlCommand("consultaLogin", conexao);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("usuario", user);
            cmd.Parameters.AddWithValue("senha", senhaHash);
            try
            {
                conexao.Open();
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds); 
                if (ds.Tables[0].Rows.Count > 0) 
                    return true;
                else
                    return false;

            }
            catch (MySqlException er)
            {
                mensagem = "Erro" + er.Message;
                return false;
            }
            finally
            {
                conexao.Close();
            }
        }

    }
}
