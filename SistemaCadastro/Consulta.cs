using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaCadastro
{
    internal class Consulta
    {
        string cliente, cpf, telefone, hora, dataD;
        int proce;

        public string Cliente { get => cliente; set => cliente = value; }
        public string Cpf { get => cpf; set => cpf = value; }
        public string Telefone { get => telefone; set => telefone = value; }
        public string Hora { get => hora; set => hora = value; }
        public string DataD { get => dataD; set => dataD = value; }
        public int Proce { get => proce; set => proce = value; }
    }
}
