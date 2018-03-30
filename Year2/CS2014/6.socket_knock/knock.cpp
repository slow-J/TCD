#include <iostream>
#include "option_handler.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <fstream>
using namespace std;

void add_options(OptionHandler::Handler & h) 
{
  
  try 
  {
    h.add_option('h', "host", OptionHandler::REQUIRED, false); 
  }
  catch (const std::exception & r) 
  {
    std::cerr << r.what() << std::endl; 
  }
  
  try
  {
    h.add_option('p', "port",   OptionHandler::REQUIRED, false);
  }
  catch (const std::exception & r) 
  {
    std::cerr << r.what() << std::endl; 
  }
  
  try 
  {
    h.add_option('w', "web",  OptionHandler::NONE, false); 
  }
  catch (const std::exception & r) 
  {
    std::cerr << r.what() << std::endl; 
  }
  
  try 
  {
    h.add_option('H', "help",  OptionHandler::NONE, false); 
  }
  catch (const std::exception & r) 
  {
    std::cerr << r.what() << std::endl; 
  }
  try 
  {
    h.add_option('?', "help",  OptionHandler::NONE, false); 
  }
  catch (const std::exception & r) 
  {
    std::cerr << r.what() << std::endl; 
  }
  try 
  {
    h.add_option('f', "file",  OptionHandler::OPTIONAL, false); 
  }
  catch (const std::exception & r)
  {
    std::cerr << r.what() << std::endl; 
  }
}

int main(int argc, char *argv[])
{
  OptionHandler::Handler hand = OptionHandler::Handler(argc,argv);
  add_options(hand);
  fstream f;
  bool isFile = false;
  
  if(hand.get_option("help"))
  {
   cout<<"usage: ./knock -h host -p port [-H] [-w] [-f file]";    
  }
  else
  {
    string hostName =  hand.get_argument("host");
    string portName = hand.get_argument("port");
    if(hand.get_option("file"))
    {
      f.open(hand.get_argument("file"),ios::out);
      isFile = true;
    }
    int stat;
    struct addrinfo hints;
    struct addrinfo *serv;  // will point to the results
    
    memset(&hints, 0, sizeof( hints)); // make sure the struct is empty
    hints.ai_family = AF_UNSPEC;     // don't care IPv4 or IPv6
    hints.ai_socktype = SOCK_STREAM; // TCP stream sockets
    hints.ai_flags = AI_PASSIVE;     // fill in my IP for me
    
    if ((stat = getaddrinfo(hostName.c_str(), portName.c_str(), &hints, &serv)) != 0) 
    {
      fprintf(stderr, "getaddrinfo error: %s\n", gai_strerror(stat));
      exit(1);
    }
    
    int mySocket =  socket(serv->ai_family, serv->ai_socktype, serv->ai_protocol);
    connect(mySocket, serv->ai_addr, serv->ai_addrlen);
    
    string message = "GET /\r\n\r\n";
    const char* msg = message.c_str();
    
    send(mySocket, msg, strlen(msg),0);
    char* buf = new char[50000];
    bzero(buf,50000);
    recv(mySocket,buf,50000, 0);
    
    if(isFile) f<<buf;
    cout<<buf; 
  }
}