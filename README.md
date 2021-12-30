# Análise do desempenho de protocolos para Computação em névoa

### Equipe: 
1834134 José Vitor Moreno josemoreno@alunos.utfpr.edu.br (41) 3672-4602 \
906867 Luís Henrique Beltrão Santana luis.2012@alunos.utfpr.edu.br (41) 99690-4570

### Professores Orientadores:
Profª. Drª. Ana Cristina B. Kochem Vendramin \
Prof. Dr. Daniel Fernando Pigatto

## Resumo

Com o avanço do poder de processamento e a miniaturização dos processadores mo-dernos, a cada ano que se passa, vê-se cada vez mais dispositivos portáteis se tornando popula-res no Brasil. Esses dispositivos se utilizam de sistemas embarcados onde o consumo de recur-sos como bateria, processamento e memória, que são escassos, são de vital importância para que o usuário tenha uma boa experiência de uso. Atualmente, os dispositivos móveis são uma grande fonte de geração de dados. Esses dados ficam situados nas bordas da rede, sendo mui-tas vezes inviável tentar centralizá-los. A camada de computação em névoa surgiu como um meio de prover serviços de armazenamento e comunicação entre a computação em nuvem e os dispositivos finais (IoT - Internet of Things), podendo fornecer dados em tempo real de forma descentralizada e escalável.  Um elemento chamado servidor de mensagens fica responsável por gerenciar e distribuir a informação através de um ou mais canais de comunicação, de modo a demandar menos recursos computacionais com requisições repetidas para uma mesma infor-mação. Este trabalho visa analisar alguns protocolos de comunicação para computação em né-voa, como MQTT (Message Queuing Telemetry Transport), AMQP (Advanced Message Queuing Protocol) e STOMP (Simple Text Orientated Messaging Protocol) por meio de um servidor de mensagens RabbitMQ. O objetivo é analisar como esses protocolos se comportam nesse novo mundo desafiador de recursos escassos, que são autogerenciados por ferramentas internas do Sistema Operacional. 

### Palavras-chave: 

Computação em névoa, Dispositivos Móveis, AMQP, STOMP, MQTT.

## DESCRIÇÃO DO PROJETO / CARACTERIZAÇÃO

### Objetivo Geral 
Este trabalho tem como objetivo geral realizar uma análise do desempenho da computação em névoa ao utilizar os protocolos STOMP, MQTT e AMQP em dispositivos móveis onde, devi-do às limitações de energia e memória, o sistema operacional pode interferir no funcionamento da interface de rede. 

### Objetivos Específicos
Os objetivos específicos desse trabalho são:
* Apresentar os conceitos de computação em névoa, suas vantagens e seus elemen-tos;
* Estudar os protocolos de comunicação STOMP, MQTT e AMQP;
* Analisar o desempenho dos protocolos STOMP, MQTT e AMPQ em relação às métricas: queda de conexão, consumo de memória, processamento e energia;

![Diagrama de blocos](./latex/dados/figuras/diagrama_de_blocos-v1.png)

O diagrama das relações entre tecnologias é mostrado na Figura 1. O dispositivo móvel é o ponto central desta aplicação, não só porque ele faz parte da comunicação que será analisa-da, mas também porque a coordena. Esta comunicação ocorre entre o dispositivo móvel e um servidor de mensagens (broker), sendo que este faz parte da camada de névoa. Essa comuni-cação é representada pela seta de numeração 8.

O RabbitMQ (RabbitMQ) foi escolhido pois, além dos integrantes já terem conhecimen-to sobre seu uso e tê-lo usado em trabalhos anteriores, esse broker tem suporte para todos os protocolos que serão analisados neste trabalho, o que ajuda a evitar divergências nos dados causadas pelo uso de diferentes brokers.
O Docker foi escolhido como servidor central por ser uma ferramenta muito flexível de modo que pode ser construída uma imagem para cada microsserviço e a partir dela levantar um serviço em segundos, sendo assim um sistema que gerencia a execução dos microsserviços. 

O Azure por sua vez é um serviço de nuvem amplamente conhecido e oferece o gerenci-amento de servidores como um serviço o que traz uma grande praticidade para o gerenciamen-to do projeto. Além disso, o Azure oferece um período de testes de um ano gratuito para o desenvolvimento de projetos como uma forma de aprender a usar a plataforma e ambos os autores têm direito a esse benefício.

Os dados de comunicação ficarão temporariamente armazenados na memória interna do dispositivo móvel, em um arquivo do formato CSV. Periodicamente, estes dados armazenados serão enviados para um banco de dados externo que será executado como um microsserviço Docker no servidor de computação em nuvem Azure. As conexões identificadas pelos núme-ros 6 e 4 representam a transmissão referida, onde os dados do arquivo CSV são transmitidos para o “Servidor Principal” e, posteriormente, são salvos em um Banco de dados. 

O banco de dados que será utilizado no projeto será o PostgreSQL, que é um banco de dados relacional robusto e que foi escolhido por uma questão de familiaridade dos autores, que já empregaram esse banco de dados em projetos anteriores.

Como forma de redundância, caso a conexão do dispositivo móvel com os microsservi-ços seja perdida, uma instância local pode ser criada e configurada no aplicativo para permitir que os testes continuem. Neste caso, as conexões representadas pelos números 7, 5 e 3 substi-tuem as conexões 8, 6 e 4, respectivamente.

Como forma de redundância, um segundo arquivo de backup CSV, gerado a partir do banco de dados, periodicamente será armazenado em outro servidor na nuvem. Esta conexão é representada pelo número 9. Em caso de queda de conexão com a instância principal do servi-dor, tratada anteriormente, a conexão 9 será substituída pela conexão de número 1.

Os dados salvos no banco de dados e nos dois arquivos CSV serão sincronizados pela ferramenta DBeaver, que permite conectar, gerenciar e migrar dados entre diversos bancos de dados e meios de armazenamento de informação como CSV. As conexões do DBeaver são apresentadas na Figura 1 pelos números 11, 9 e 2.

O Flutter é um novo framework da Google que permite desenvolver a interface gráfica e a lógica de negócio que podem ser usadas para criar aplicações para Android e iOS com um único código base, de modo que os códigos nativos são autogerados.

Para a realização dos testes relativos à memória, processamento e energia as plataformas Android e iOS possuem ferramentas que permitem analisar essas características durante a exe-cução da aplicação.

## MOTIVAÇÃO E RESULTADOS ESPERADOS
