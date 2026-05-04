component rest="true" restpath="/hello" {
    remote string function sayHello() httpmethod="GET" restpath="" {
        return "HELLO FROM REST!";
    }
}