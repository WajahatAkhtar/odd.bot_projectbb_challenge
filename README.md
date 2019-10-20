# Post Processing data :
- clone the repository first : 
- move to utils folder and run : $ python3 process_train_no_split.py  
				 $ python3 process_val_no_split.py  
				 $ python3 process_test_no_split.py  
- The split data files will be generated in the folder split_data
- the data is stored in : /home/challenge/input_data/cig_butts/train/ /home/challenge/input_data/cig_butts/val/ /home/challenge/input_data/cig_butts/real_test/
- Once the data is generated in the desired format as yolo : e.g add labels, and image in the same folder sorted.
- Now we can proceed with training : 

IMP NOTE : The data is already processed so need to perform the above steps again :

# Training
- docker build -f Dockerfile -t vision_challenge_gpu_training .
- docker images
- Manual : 
	- nvidia-docker run -it -v /home/challenge/input_data:/root/input_data/ -v /home/challenge/output_result:/root/output_result/ --name vision_challenge_yolo_container vision_challenge_gpu_training
	- ./train.sh cfg/coco_cig.data cfg/yolov2.cfg darknet19_448.conv.23
- Automatic : 
        -  Training :   
	-  Test Single file : run -it -v /home/challenge/input_data:/root/input_data/ -v /home/challenge/output_result:/root/output_result/ --name vision_challenge_yolo_container vision_challenge_gpu_training  /bin/bash ./test_single_image.sh cfg/coco_cig.data cfg/yolov2.cfg /root/input_data/trained_weights_yolo/yolov2_final.weights /root/input_data/cig_butts/real_test/0003.JPG
	-  Test Multiple file :  nvidia-docker run --rm -it -v /home/challenge/input_data:/root/input_data/ -v /home/challenge/output_result:/root/output_result/ --name vision_challenge_yolo_container vision_challenge_gpu_training  /bin/bash ./test_multiple_list_images.sh	
# Testing 
	- ./test_single_image.sh cfg/coco_cig.data cfg/yolov2.cfg /root/input_data/trained_weights_yolo/yolov2_final.weights /root/input_data/cig_butts/real_test/0003.JPG

# Testing multiple images : 
	- ./test_multiple_list_images.sh cfg/coco_cig.data cfg/yolov2.cfg /root/input_data/trained_weights_yolo/yolov2_final.weights -ext_output <split_data/test.txt> result.txt


# To start and attach a stop container
- docker start vision_challenge_yolo_container
- docker attach vision_challenge_yolo_container

# To remove a container
- docker ps -a
- docker rm vision_challenge_yolo_container 





# Odd.bot/ProjectBB Coding Challenge

## Motivation:
The reason why we do this coding challenge is to show you and us how the future work will be organised and which level of autonomy is required to work in the thesis.
Additionally we want to make sure that we can communicate with you and you can communicate with us.
As the last point we want to make sure that you are capable of creating a solution to a problem we have to solve and like your coding style. But most of all the use of the tools is important in this challenge.

There will be two challenges and the difficulty will probably not be the same - but both lead to different thesis topics. The first is the Computer Vision challenge for a vision based thesis, the second is the Reinforcement Learning challenge for an actuator based thesis.

In general, if you struggle with the instructions, tools or the task, please feel free to contact me.

Sending in the solution means that you have to add me to your (private) GitHub repository and I will then check out the code. My username on GitHub is w1kke - you can add me right away and then I can check your code while you work on it. In the mail you receive there will be a repository that functions as the start of your challenge and you have to fork it to your own (private) repository. We will work on Docker images to make sure that the execution of the code does not rely on local configurations and can work on your own machine, AWS VMs and my machine as well.

I will also provide you with access to a virtual machine (VM) on Amazon Web Services so you have access to a GPU instance - please see the mail.

## Computer Vision challenge:
This challenge involves training a DNN to recognize cigarette butts.
We follow this blog article where the author created an artificial set of cigarette butt images and already explains that he trained a DNN to recognize them:
https://medium.com/@aktwelve/training-an-ai-to-recognize-cigarette-butts-5cff9e11c0a7
The data is available here:
http://www.immersivelimit.com/datasets/cigarette-butts
Please train the cigarette butts as a new class in YOLOv2 for Tensorflow.

## Reinforcement Learning challenge:
This challenges involves setting up an OpenAI gym environment and getting it to train to pick up an item in this environment - this task is open ended as getting this to run and succeed is already quite a time consuming effort. The further you get the better.
This a blog post about the setup in the OpenAI gym:
https://openai.com/blog/ingredients-for-robotics-research/

And this is the corresponding gym environment:
https://gym.openai.com/envs/FetchPickAndPlace-v0/




