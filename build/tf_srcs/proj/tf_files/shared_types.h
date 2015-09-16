/**
 * Autogenerated by Thrift Compiler (1.0.0-dev)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */
#ifndef shared_TYPES_H
#define shared_TYPES_H

#include <iosfwd>

#include <thrift/Thrift.h>
#include <thrift/TApplicationException.h>
#include <thrift/protocol/TProtocol.h>
#include <thrift/transport/TTransport.h>

#include <thrift/cxxfunctional.h>


namespace shared {

class SharedStruct;

typedef struct _SharedStruct__isset {
  _SharedStruct__isset() : key(false), value(false) {}
  bool key :1;
  bool value :1;
} _SharedStruct__isset;

class SharedStruct {
 public:

  SharedStruct(const SharedStruct&);
  SharedStruct& operator=(const SharedStruct&);
  SharedStruct() : key(0), value() {
  }

  virtual ~SharedStruct() throw();
  int32_t key;
  std::string value;

  _SharedStruct__isset __isset;

  void __set_key(const int32_t val);

  void __set_value(const std::string& val);

  bool operator == (const SharedStruct & rhs) const
  {
    if (!(key == rhs.key))
      return false;
    if (!(value == rhs.value))
      return false;
    return true;
  }
  bool operator != (const SharedStruct &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const SharedStruct & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

  friend std::ostream& operator<<(std::ostream& out, const SharedStruct& obj);

};

void swap(SharedStruct &a, SharedStruct &b);

} // namespace

#endif
