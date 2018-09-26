//================================
// Modelo Novo-Keynesiano Básico 
//================================

//----------------
// Preâmbulo
//----------------

/* Nota: No preâmbulo vamos definir:
	1) variáveis do modelo,
	2) variáveis exógenas, 
	3) parâmetros
	4) Calibrar/valores iniciais.
*/ 

// 1. Variáveis do modelo

var ppi    		// 1. inflação 
	y_gap  		// 2. hiato do produto
	i      		// 3. taxa de juros nominal
	r_nat  		// 4. taxa de juros natural
	r_real 		// 5. taxa de juros real
	y_nat  		// 6. produto natural
	nu     		// 7. processo AR(1) do choque de política monetária
	a      		// 8. processo AR(1) do choque tecnológico
	y      		// 9. produto
	n      		// 10. horas trabalhadas
	pi_an 		// 11. inflação anualizada
	r_real_an   // 12. taxa de juros real anualizada
	r_nat_an    // 13. taxa natural de juros anualizada
	i_an 		// 14. taxa nominal de juros anualizada
	m_cresc_an  // 15. crescimento da oferta de moeda anualizado   
	m_real     // 16. demanda por moeda real
	n_an;



// 2. Choques exógenos

varexo eps_nu // choque de política monetária
	   eps_a; // choque tecnológico 

// 3. Parâmetros

parameters betta  // fator de desconto intertemporal
	       siggma // elasticidade de substituição intertemporal
	       phi    // elasticidade frisch
	       epsilon// elasticidade da demanda 
	       phi_pi // resposta do BC ao juros
	       phi_y  // resposta do BC ao hiato do produto
	       alppha // participação do capital
	       thetta // parâmetro de calvo
	       rho_nu // persistência do choque monetário
	       rho_a  // persistência do choque tecnológico
	       eta;   // elasticidade da demanda por moera

// 4. Calibrar

betta  = 0.99;
siggma = 1;
phi    = 1;
epsilon= 6;
phi_pi = 1.5;
phi_y  = 0.5/4;
alppha = 1/3;
thetta = 2/3;
rho_nu = 0.5;
rho_a  = 0.9;
eta    = 4;


//----------------
// Modelo (CPO)
//----------------


model(linear);

// Parâmetros compostos
#Omega    = (1-alppha)/(1-alppha+alppha*epsilon);       // definido na p. 47
#psi_n_ya = (1+phi)/(siggma*(1-alppha)+phi+alppha);     // definido na p. 48
#lambda   = ((1-thetta)*(1-betta*thetta)/thetta)*Omega; // definido na p. 47
#kappa    = lambda*(siggma+(phi+alppha)/(1-alppha));    // definido na p. 49

// 1. Curva de Phillips Novo-Keynesiano
ppi = betta*ppi(+1) + kappa*y_gap;

// 2. Curva IS dinâmica
y_gap = y_gap(+1) -(1/siggma)*(i - ppi(+1) - r_nat);

// 3. Regra de juros
i = phi_pi*ppi + phi_y*y_gap + nu;

// 4. Taxa de juros natural
r_nat = siggma*psi_n_ya*(a(+1) - a);

// 5. Taxa de juros real
r_real = i - ppi(+1);

// 6. Produto natural
y_nat = psi_n_ya*a;

// 7. Hiato do produto
y_gap = y - y_nat;

// 8. Processo AR(1) pol. mon.
nu = rho_nu*nu(-1) + eps_nu;

// 9. Processo AR(1) choque tecnológico
a = rho_a*a(-1) + eps_a;

// 10. Função de produção
y = a +(1+alppha)*n;

// 11. Taxa nominal de juros anualizada
i_an = 4*i;

// 12. Taxa natural de juros anualizada
r_nat_an = 4*r_nat;

// 13. Taxa de juros real anualizada
r_real_an = 4* r_real;

// 14. Inflação anualizada
pi_an = 4*ppi;

// 15. Crescimento da moeda
m_cresc_an = 4*(y-y(-1)-eta*(i-i(-1))+ppi);

// 16. Demanda real por moeda
m_real = y-eta*i;

// 17. Emprego anual
n_an = 4*n;

end;

//----------------
// Choques
//----------------

shocks;
	var eps_nu = 0.25^2; // choque de 1 desvio-padrão (anualziado)
	var eps_a  = 1; // choque unitário de tecnologia
end; 

// Estado estacionário


resid(1);
steady;
check;

//------------------
// Simulações
//------------------

// Choque de política monetária

stoch_simul(order = 1,    // Ordem da aproximação de taylor
			irf=12,       // Número de passos a frente da função impulso resposta (fir)
			periods=200)  // Tamanho da amostra a ser simulada
			y_gap pi_an i_an r_real_an m_cresc_an nu; // Variáveis da fir

// Choque tecnológico

/*stoch_simul(order = 1,    // Ordem da aproximação de taylor
			irf=12,       	// Número de passos a frente da função impulso resposta (fir)
			periods=200)  	// Tamanho da amostra a ser simulada
			y_gap pi_an y n_an i_an r_real_an m_cresc_an a;