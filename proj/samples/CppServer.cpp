/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

#include <thrift/concurrency/ThreadManager.h>
#include <thrift/concurrency/PlatformThreadFactory.h>
#include <thrift/protocol/TBinaryProtocol.h>
#include <thrift/server/TSimpleServer.h>
#include <thrift/server/TThreadPoolServer.h>
#include <thrift/server/TThreadedServer.h>
#include <thrift/server/TNonblockingServer.h>
#include <thrift/transport/TServerSocket.h>
#include <thrift/transport/TSocket.h>
#include <thrift/transport/TTransportUtils.h>
#include <thrift/TToString.h>

#include <boost/make_shared.hpp>

#include <iostream>
#include <stdexcept>
#include <sstream>

#include "proj/samples/tf_files/Calculator.h"
#include <unistd.h>
#include <sys/syscall.h>

using namespace std;
using namespace apache::thrift;
using namespace apache::thrift::concurrency;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;
using namespace apache::thrift::server;

using namespace tutorial;
using namespace shared;
volatile int _G_flag = 0;
class CalculatorHandler : public CalculatorIf {
public:
  CalculatorHandler() {}

  void ping() { cout << "ping()" << endl; 
  cout << "tid: " << syscall(SYS_gettid) << endl;
  #ifdef HUNG_UP1
    if (_G_flag++ % 2 == 0) {
        sleep(12000);
    }
  #endif
  #ifdef HUNG_UP2
    if (_G_flag++ % 2 == 1) {
        sleep(12000);
    }
  #endif
    sleep(20);
  }

  int32_t add(const int32_t n1, const int32_t n2) {
    cout << "add(" << n1 << ", " << n2 << ")" << endl;
    return n1 + n2;
  }

  int32_t calculate(const int32_t logid, const Work& work) {
    cout << "calculate(" << logid << ", " << work << ")" << endl;
    int32_t val;

    switch (work.op) {
    case Operation::ADD:
      val = work.num1 + work.num2;
      break;
    case Operation::SUBTRACT:
      val = work.num1 - work.num2;
      break;
    case Operation::MULTIPLY:
      val = work.num1 * work.num2;
      break;
    case Operation::DIVIDE:
      if (work.num2 == 0) {
        InvalidOperation io;
        io.whatOp = work.op;
        io.why = "Cannot divide by 0";
        throw io;
      }
      val = work.num1 / work.num2;
      break;
    default:
      InvalidOperation io;
      io.whatOp = work.op;
      io.why = "Invalid Operation";
      throw io;
    }

    SharedStruct ss;
    ss.key = logid;
    ss.value = to_string(val);

    log[logid] = ss;

    return val;
  }

  void getStruct(SharedStruct& ret, const int32_t logid) {
    cout << "getStruct(" << logid << ")" << endl;
    ret = log[logid];
  }

  void zip() { cout << "zip()" << endl; }

protected:
  map<int32_t, SharedStruct> log;
};

/*
  CalculatorIfFactory is code generated.
  CalculatorCloneFactory is useful for getting access to the server side of the
  transport.  It is also useful for making per-connection state.  Without this
  CloneFactory, all connections will end up sharing the same handler instance.
*/
class CalculatorCloneFactory : virtual public CalculatorIfFactory {
 public:
  virtual ~CalculatorCloneFactory() {}
  virtual CalculatorIf* getHandler(const ::apache::thrift::TConnectionInfo& connInfo)
  {
    boost::shared_ptr<TSocket> sock = boost::dynamic_pointer_cast<TSocket>(connInfo.transport);
    cout << "Incoming connection\n";
    cout << "\tSocketInfo: "  << sock->getSocketInfo() << "\n";
    cout << "\tPeerHost: "    << sock->getPeerHost() << "\n";
    cout << "\tPeerAddress: " << sock->getPeerAddress() << "\n";
    cout << "\tPeerPort: "    << sock->getPeerPort() << "\n";
    return new CalculatorHandler;
  }
  virtual void releaseHandler( ::shared::SharedServiceIf* handler) {
    delete handler;
  }
};

int main() {
/*  TThreadedServer server(
    boost::make_shared<CalculatorProcessorFactory>(boost::make_shared<CalculatorCloneFactory>()),
    boost::make_shared<TServerSocket>(9090), //port
    boost::make_shared<TBufferedTransportFactory>(),
    boost::make_shared<TBinaryProtocolFactory>());
*/
  /*
  // if you don't need per-connection state, do the following instead
  TThreadedServer server(
    boost::make_shared<CalculatorProcessor>(boost::make_shared<CalculatorHandler>()),
    boost::make_shared<TServerSocket>(9090), //port
    boost::make_shared<TBufferedTransportFactory>(),
    boost::make_shared<TBinaryProtocolFactory>());
  */

 //  * Here are some alternate server types...

  // This server only allows one connection at a time, but spawns no threads
/*  TSimpleServer server(
    boost::make_shared<CalculatorProcessor>(boost::make_shared<CalculatorHandler>()),
    boost::make_shared<TServerSocket>(9090),
    boost::make_shared<TBufferedTransportFactory>(),
    boost::make_shared<TBinaryProtocolFactory>());
*/
  /*const int workerCount = 4;

  boost::shared_ptr<ThreadManager> threadManager =
    ThreadManager::newSimpleThreadManager(workerCount, 100);
  threadManager->threadFactory(
    boost::make_shared<PlatformThreadFactory>());
  threadManager->start();*/

  // This server allows "workerCount" connection at a time, and reuses threads
  /*TThreadPoolServer server(
    boost::make_shared<CalculatorProcessorFactory>(boost::make_shared<CalculatorCloneFactory>()),
    boost::make_shared<TServerSocket>(9090),
    boost::make_shared<TBufferedTransportFactory>(),
    boost::make_shared<TBinaryProtocolFactory>(),
    threadManager);*/
  //boost::shared_ptr<ThreadManager> threadManager =
    //ThreadManager::newSimpleThreadManager(2);
  //threadManager->threadFactory(
    //boost::make_shared<PlatformThreadFactory>());
  //threadManager->start();
  /*TNonblockingServer server(
    boost::make_shared<CalculatorProcessorFactory>(boost::make_shared<CalculatorCloneFactory>()),
    boost::make_shared<TBinaryProtocolFactory>(),
    9090);
    //threadManager);
  server.setNumIOThreads(2);*/

  /*boost::shared_ptr<ThreadManager> threadManager =
    ThreadManager::newSimpleThreadManager(3);
  threadManager->threadFactory(
    boost::make_shared<PlatformThreadFactory>());
  threadManager->start();
  TNonblockingServer server(
    boost::make_shared<CalculatorProcessorFactory>(boost::make_shared<CalculatorCloneFactory>()),
    boost::make_shared<TBinaryProtocolFactory>(), 9090, threadManager);
  server.setNumIOThreads(1);*/

  /*最基础的多线程Nonblocking !注意，主线程既是监听线程又是工作线程*/
  //TNonblockingServer server(
    //boost::make_shared<CalculatorProcessorFactory>(boost::make_shared<CalculatorCloneFactory>()), 9090);
  //server.setNumIOThreads(3);

  /*最基础的单线程Nonblocking*/
  TNonblockingServer server(
    boost::make_shared<CalculatorProcessorFactory>(boost::make_shared<CalculatorCloneFactory>()), 9090);

  cout << "Starting the server..." << endl;
  server.serve();
  cout << "Done." << endl;
  return 0;

}
