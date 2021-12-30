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

![Diagrama de blocos](./latex/dados/figuras/)



