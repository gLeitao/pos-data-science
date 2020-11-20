<h1> Explanação do Projeto </h1>

<p>

  O projeto em si se trata em aplicar tecnicas e algoritmos de Analise de Componentes Principais (PCA) em uma base de rostos com o intuito de 
realizar o reconhecimento facial das imagens disponibilizadas.

  Para o desenvolvimento do projeto, foi utilizado a linguagem python em conjunto com a biblioteca cv2, onde que a biblioteca é utilziada tanto 
para fazer o pre-processamento das imagens quanto para treinar o algoritmo de identificação facial.

  Para fazer o pre-processamento foi utilziado o algoritmo cvtColor, passando como parametro COLOR_BGR2GRAY, o qual é responsavel por converter 
as imagens inputadas para tons de cinza, o que facilita a identificação e classificação do algoritmo de reconhecimento facial.
 
  E para realizar a identificação facial foi utilizado o algoritmo EigenFaceRecognizer, que internamente faz o uso de PCA para calcular a diferença 
entre as imagens e determinar qual o grupo mais proximo a mesma pertence. 

</p>

<h1> Rodando o Código </h1>

<p>

Primeiro passo é certificar que as bibliotecas python abaixo estão instaladas e atualizadas no ambiente:

 - cv2
 - numpy
 - sklearn
 - matplotlib
 

Obs.: É aconcelhavel criar um ambiente virtual com as bibliotecas acima para que não impacto projetos pessoais de seu ambiente atual. Caso opte por não criar 
um ambiente virtual se atente a documentação da biblioteca CV2 (https://pypi.org/project/opencv-python/) onde requer que qualquer instalação previa do open-cv 
seja desisntalada para evitar qualquer tipo de conflito com a biblioteca atual.

</br>

Segundo passo é rodar o script trabalho_reconhecimento_facial.py ou caso prefira no jupyter notebook rodar o script trabalho_reconhecimento_facial.ipynb, ambos scripts disponiveis neste repositorio.

</p>


<h1> Amostragem de Resultados Obtidos </h1>

<p>

Apos o treinamento do modelo, foram obtidos os resultados abaixo:  

 - 10 Componentes principais, acurácia:  94.31 %
 - 11 Componentes principais, acurácia:  95.12 %
 - 12 Componentes principais, acurácia:  95.12 %
 - 13 Componentes principais, acurácia:  95.12 %
 - 14 Componentes principais, acurácia:  93.5 %
 - 15 Componentes principais, acurácia:  93.5 %
 - 16 Componentes principais, acurácia:  94.31 %
 - 17 Componentes principais, acurácia:  94.31 %
 - 18 Componentes principais, acurácia:  93.5 %
 - 19 Componentes principais, acurácia:  93.5 %
 - 20 Componentes principais, acurácia:  94.31 %
 
</br>

Mais detalhes sobre a execução podem ser analistados nos arquivos trabalho_reconhecimento_facial.ipynb e trabalho_reconhecimento_facial.html, disponibilziados neste respositorio.

</p>

