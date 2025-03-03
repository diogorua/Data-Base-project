# Data Base Project

A web-based (HTML/PHP) prototype created to demonstrate the Information System which ensures the management of a wine distribution company. It also allows the company to manage its data intuitively and efficiently

## ✅ Prerequisites

- XAMPP which is the most popular PHP development environment
   - [Click here to install](https://www.apachefriends.org/)

## ⚙️ Run the web-based prototype (divided by two parts)

### First part

- After the complete installation, open XAMP as administrator 
- You will see the XAMP Control Panel and then you just have to click on Start related to Apache and MySQL 
- Click the button Admin related to MySQL and it will open PHPMyAdmin, a web based graphical interface (GUI) for the MariaDB database management System
- In the left corner click on New (it will create a new database), give it a name (it has to be **vinisys** to connect successfully) and click on create
- As you can see, you have a menu with different options
   - Click on Import and select a file. In this case you have to choose **vinisys.sql**. Scroll down and finally import the SQL file
- You have just imported a file which contains different tables with all the data related to Vinisys (our Information System)

### Second part

- Now, with all the Information above, go to your file explorer and search for folder that contains all the installation about XAMP
   - Among all the folders, click on **htdocs** and I recommend you (inside that folder) to create another folder called vinisys
   - Copy paste all the files with php and html extension (from this repository) to vinisys folder. Only with this way we will be connecting our web-based prototype to our database
- The last part is the easiest part, [click here](http://localhost/vinisys/menu.html) and you will be acessing my web-based system created in this project
   - There you can insert or register new harvests, see the list of wines availables in the database we created in the first part and we can also see a list of clients and how many wines they purchased
   - Fell free to explore whatever you want and try to introduce, for example, new harvests or insert new more clients on database and then you will see that in the web system, the client is already there. 

## 📖 Summary

- With this project I finally understood how it really works, the connection between the database and a simple web-based system. How incredible things are when you can insert a client into the database and then automatically, doing a refresh, he will appear on our web page in the list of clients. Or if we just remove a client, he will also be removed from the database. A very nice experience that contribute to increase my skills in PHP and also helped to learn how the back-end works (despite it being a simple project and not even close to what the back-end projects out there are), like when we do a login and the system display an information saying that we are not registered. Here it's the same but a little more simplified.