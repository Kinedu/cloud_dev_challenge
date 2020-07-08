# Cloud Developer Challenge

El propósito de este reto es conocer más a detalle la manera en la que implementas un proyecto web utilizando servicios en la nube de AWS y conocer tu proceso para resolver los requerimientos. 


LA MISIÓN
-----------

El departamento de marketing quiere agregar una nueva sección a la landpage de uno de sus productos. Tu misión será hacer un arreglo de validación y agregar la funcionalidad de un formulario de contacto usando un api serverless que está construido en Sinatra y hospedado en AWS utilizando API Gateway, Lambda y DynamoDB.

![Architecture Diagram](/docs/request.png)


## SETUP

Antes de comenzar necesitas tener una cuenta en github, una cuenta en AWS, Ruby 2.5 en adelante y AWS CLI instalados en tu computadora.

Para comenzar, haz un clone del código del proyecto que se encuentra en aquí. Instala el stack de componente que ya está definido en el template de Cloudformation en tu cuenta de AWS. Puedes seguir las instrucciones que estan en la sección 'Deploy in the cloud' en este mismo README.


## QUICK FIXES

Para que te familiarices con el código comenzaremos con hacer una validación en la forma del ebook (localhost:4567/landpage). Actualmente acepta enviar el formulario en blanco y no valida el formato del email. La validación la puedes realizar en cualquier capa de la aplicación, solo considera notificarle al usuario en la vista que su forma no fue aceptada por no cumplir alguna validación.
- Valida que la forma no acepte campos en blanco
- Valida que el texto ingresado en el campo de email tenga un formato de email (tucorreo@tudominio.com)

![Leads form screenshoot](/docs/form_1.png)


## NEW FEATURE

Ahora que ya conoces mejor el proyecto, es momento de agregar una nueva funcionalidad.
Se necesita hacer funcional la forma de contacto de manera que cada vez que un usuario llene la forma con su nombre, email y mensaje, se guarden estos datos en una nueva tabla en DynamoDB. Los datos de esta tabla serán visibles al invocar un endpoint que liste en formato JSON los mensaje recibidos. Finalmente todos los usuarios que envíen un mensaje desde la forma de contacto, deberán de ser guardados también en la tabla de 'LandpageLeads'.

![Contact form screenshoot](/docs/form_2.png)

**1.Crea una tabla nueva**

Crea una tabla nueva en DynamoDB llamada  'ContactMessages' con 2 unidades de capacidad de lectura y 2 unidades de escritura, configura ID como llave primaria y Email como llave secundaria global. Actualiza el template de Cloudformation que se incluye en el código 'template.yml' para crear la tabla.

![table diagram](/docs/tables.png)


**2.Crea los endpoints**

Crea los nuevos endpoints en API que permiten crear, ver y buscar la lista de mensajes de contacto siguiendo el diseño del API.

![api design](/docs/api.png)

![object design](/docs/object.png)


**3.Conecta la vista con el API**

Conecta el endpoint con la vista de la forma de contacto. Valida que no se envíe una forma vacía y el formato del correo electrónico sea el correcto. Cuando la forma de contacto haya sido guardada en la tabla de Dynamo, notifica al usuario en la vista que su forma ha sido enviada.

Al guardar la forma de contacto también guarda los datos del usuario (email y nombre) en la tabla de 'LandpageLeads'. Al crear un nuevo registro en la tabla de leads pueden existir campos en blanco excepto el de ID.

**4. Envia tu código y limpia tu entorno**

Al terminar, actualiza el código en Github, envía la liga de tu git al correo evelin@kinedu.com 
**MUY IMPORTANTE: Elimina el stack de tu cuenta de AWS para que no te genere costo.** https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-console-delete-stack.html


## EXTRAS
La prueba tiene una duración de 2-4 horas y se evalúa que los requerimientos hayan sido completados exitosamente. Cualquier funcionalidad adicional como autenticación, implementación de pruebas, paginación, manejo de errores, mejora de diseño visual u otra funcionalidad o validación que desees agregar se considerará como puntos extras para la evaluación de la prueba y son completamente opcionales pero puede ayudarte a demostrar habilidades que los requerimientos principales no abarcan. Al enviar la prueba, **por favor notifica las funcionalidades extras para incluirlas en la evaluación.**


## TIPS
- Lee el código, podrás encontrar parte de la solución en otras funcionalidades ya programadas. Aun así, si crees que hay una mejor forma de solucionar las tareas te invitamos a que nos compartas tus propuestas. 
- Al final de este documento agregamos ligas de algunas referencias que te pueden ser útiles si no estás familiarizado con algunas de las tecnologías que usa este proyecto.
- Cualquier duda que tengas acerca de las tareas puedes enviarla a evelin@kinedu.com


## RECURSOS

If it's your first time working with SAM, this article could help https://medium.com/@gurlgilt/deploying-aws-sam-lambda-api-gateway-dynamodb-and-s3-ad11e619d322

Additional details can be found at: https://aws.amazon.com/blogs/compute/announcing-ruby-support-for-aws-lambda/

Ruby Sinatra on AWS Lambda: https://blog.eq8.eu/article/sinatra-on-aws-lambda.html

Create a DynamoTable in Cloudformation https://docs.aws.amazon.com/es_es/AWSCloudFormation/latest/UserGuide/aws-resource-dynamodb-table.html

Learn more about Serverless Application Model (SAM) and how it works here: https://github.com/awslabs/serverless-application-model/blob/master/HOWTO.md

AWS Lambda Developer Guide: http://docs.aws.amazon.com/lambda/latest/dg/deploying-lambda-apps.html

Search with Dynamo https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GettingStarted.Ruby.04.html



## DEPLOY IN THE CLOUD
-----------

This exercise includes:

* README.md - this file
* Gemfile - Gem requirements for the sample application
* app/config.ru - this file contains configuration for Rack middleware
* app/server.rb - this file contains the code for the sample service
* app/views - this directory has the template files
* spec/ - this directory contains the RSpec unit tests for the sample application
* template.yaml - this file contains the description of AWS resources used by AWS
  CloudFormation to deploy your serverless application
* pipeline-cfn.yaml - this is the CloudFormation template to create the CodePipeline and the other needed resources. You need to fork the repo if you use a personal GitHub token
* buildspec.yml - this file contains build commands used by AWS CodeBuild

Getting Started
---------------

These directions assume you already have Ruby 2.5.x and [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/installing.html) installed and configured.

To work on the exercise code, you'll need to clone your project's repository to your local computer. If you haven't, do that first. You can find a guide [here](https://help.github.com/articles/cloning-a-repository/).

1. Ensure you are using ruby version 2.5.x

2. Install bundle

        $ gem install bundler -v "~> 1.17"

3. Install Ruby dependencies for this service

        $ bundle install

4. Download the Gems to the local vendor directory

        $ bundle install --deployment

5. Create a S3 Bucket. Save the name, you will use it in the next step

6. Create the deployment package

    Install [SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html) and run the following command

        $ sam package \
            --template-file template.yaml \
            --output-template-file serverless-output.yaml \
            --s3-bucket { your-S3-bucket-name }
            
6. Deploying your application

        $ sam deploy \
            --template-file serverless-output.yaml \
            --stack-name cloud-dev-challenge \
            --capabilities CAPABILITY_IAM

7. Once the deployment is complete, you can find the application endpoint from the CloudFormation outputs tab. Alternatively, you can find it under the Stages link from the API gateway console.

8. Run the application in localhost

        ```sh
        ruby app/server.rb
        ```



## License

This project is inspired in AWS SAMPLES: https://github.com/aws-samples/serverless-sinatra-sample and licensed under the Apache 2.0 License.
