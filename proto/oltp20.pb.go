// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.26.0
// 	protoc        v3.15.8
// source: proto/oltp20.proto

package oltp20

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type StageLocation struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Name       string `protobuf:"bytes,10,opt,name=name,proto3" json:"name,omitempty"`
	Latitude   string `protobuf:"bytes,20,opt,name=latitude,proto3" json:"latitude,omitempty"`
	Longitude  string `protobuf:"bytes,30,opt,name=longitude,proto3" json:"longitude,omitempty"`
	LocationId string `protobuf:"bytes,40,opt,name=location_id,json=locationId,proto3" json:"location_id,omitempty"`
}

func (x *StageLocation) Reset() {
	*x = StageLocation{}
	if protoimpl.UnsafeEnabled {
		mi := &file_proto_oltp20_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *StageLocation) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*StageLocation) ProtoMessage() {}

func (x *StageLocation) ProtoReflect() protoreflect.Message {
	mi := &file_proto_oltp20_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use StageLocation.ProtoReflect.Descriptor instead.
func (*StageLocation) Descriptor() ([]byte, []int) {
	return file_proto_oltp20_proto_rawDescGZIP(), []int{0}
}

func (x *StageLocation) GetName() string {
	if x != nil {
		return x.Name
	}
	return ""
}

func (x *StageLocation) GetLatitude() string {
	if x != nil {
		return x.Latitude
	}
	return ""
}

func (x *StageLocation) GetLongitude() string {
	if x != nil {
		return x.Longitude
	}
	return ""
}

func (x *StageLocation) GetLocationId() string {
	if x != nil {
		return x.LocationId
	}
	return ""
}

type LocationStatus struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Status string `protobuf:"bytes,1,opt,name=status,proto3" json:"status,omitempty"`
}

func (x *LocationStatus) Reset() {
	*x = LocationStatus{}
	if protoimpl.UnsafeEnabled {
		mi := &file_proto_oltp20_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *LocationStatus) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*LocationStatus) ProtoMessage() {}

func (x *LocationStatus) ProtoReflect() protoreflect.Message {
	mi := &file_proto_oltp20_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use LocationStatus.ProtoReflect.Descriptor instead.
func (*LocationStatus) Descriptor() ([]byte, []int) {
	return file_proto_oltp20_proto_rawDescGZIP(), []int{1}
}

func (x *LocationStatus) GetStatus() string {
	if x != nil {
		return x.Status
	}
	return ""
}

var File_proto_oltp20_proto protoreflect.FileDescriptor

var file_proto_oltp20_proto_rawDesc = []byte{
	0x0a, 0x12, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x2f, 0x6f, 0x6c, 0x74, 0x70, 0x32, 0x30, 0x2e, 0x70,
	0x72, 0x6f, 0x74, 0x6f, 0x12, 0x06, 0x6f, 0x6c, 0x74, 0x70, 0x32, 0x30, 0x22, 0x7e, 0x0a, 0x0d,
	0x53, 0x74, 0x61, 0x67, 0x65, 0x4c, 0x6f, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x12, 0x12, 0x0a,
	0x04, 0x6e, 0x61, 0x6d, 0x65, 0x18, 0x0a, 0x20, 0x01, 0x28, 0x09, 0x52, 0x04, 0x6e, 0x61, 0x6d,
	0x65, 0x12, 0x1a, 0x0a, 0x08, 0x6c, 0x61, 0x74, 0x69, 0x74, 0x75, 0x64, 0x65, 0x18, 0x14, 0x20,
	0x01, 0x28, 0x09, 0x52, 0x08, 0x6c, 0x61, 0x74, 0x69, 0x74, 0x75, 0x64, 0x65, 0x12, 0x1c, 0x0a,
	0x09, 0x6c, 0x6f, 0x6e, 0x67, 0x69, 0x74, 0x75, 0x64, 0x65, 0x18, 0x1e, 0x20, 0x01, 0x28, 0x09,
	0x52, 0x09, 0x6c, 0x6f, 0x6e, 0x67, 0x69, 0x74, 0x75, 0x64, 0x65, 0x12, 0x1f, 0x0a, 0x0b, 0x6c,
	0x6f, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x5f, 0x69, 0x64, 0x18, 0x28, 0x20, 0x01, 0x28, 0x09,
	0x52, 0x0a, 0x6c, 0x6f, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x49, 0x64, 0x22, 0x28, 0x0a, 0x0e,
	0x4c, 0x6f, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x53, 0x74, 0x61, 0x74, 0x75, 0x73, 0x12, 0x16,
	0x0a, 0x06, 0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x06,
	0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x32, 0x56, 0x0a, 0x0d, 0x4f, 0x4c, 0x54, 0x50, 0x32, 0x30,
	0x53, 0x65, 0x72, 0x76, 0x69, 0x63, 0x65, 0x12, 0x45, 0x0a, 0x14, 0x4c, 0x6f, 0x63, 0x61, 0x74,
	0x69, 0x6f, 0x6e, 0x4e, 0x6f, 0x74, 0x69, 0x66, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x12,
	0x15, 0x2e, 0x6f, 0x6c, 0x74, 0x70, 0x32, 0x30, 0x2e, 0x53, 0x74, 0x61, 0x67, 0x65, 0x4c, 0x6f,
	0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x1a, 0x16, 0x2e, 0x6f, 0x6c, 0x74, 0x70, 0x32, 0x30, 0x2e,
	0x4c, 0x6f, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x53, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x0e,
	0x5a, 0x0c, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x2f, 0x6f, 0x6c, 0x74, 0x70, 0x32, 0x30, 0x62, 0x06,
	0x70, 0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_proto_oltp20_proto_rawDescOnce sync.Once
	file_proto_oltp20_proto_rawDescData = file_proto_oltp20_proto_rawDesc
)

func file_proto_oltp20_proto_rawDescGZIP() []byte {
	file_proto_oltp20_proto_rawDescOnce.Do(func() {
		file_proto_oltp20_proto_rawDescData = protoimpl.X.CompressGZIP(file_proto_oltp20_proto_rawDescData)
	})
	return file_proto_oltp20_proto_rawDescData
}

var file_proto_oltp20_proto_msgTypes = make([]protoimpl.MessageInfo, 2)
var file_proto_oltp20_proto_goTypes = []interface{}{
	(*StageLocation)(nil),  // 0: oltp20.StageLocation
	(*LocationStatus)(nil), // 1: oltp20.LocationStatus
}
var file_proto_oltp20_proto_depIdxs = []int32{
	0, // 0: oltp20.OLTP20Service.LocationNotification:input_type -> oltp20.StageLocation
	1, // 1: oltp20.OLTP20Service.LocationNotification:output_type -> oltp20.LocationStatus
	1, // [1:2] is the sub-list for method output_type
	0, // [0:1] is the sub-list for method input_type
	0, // [0:0] is the sub-list for extension type_name
	0, // [0:0] is the sub-list for extension extendee
	0, // [0:0] is the sub-list for field type_name
}

func init() { file_proto_oltp20_proto_init() }
func file_proto_oltp20_proto_init() {
	if File_proto_oltp20_proto != nil {
		return
	}
	if !protoimpl.UnsafeEnabled {
		file_proto_oltp20_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*StageLocation); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_proto_oltp20_proto_msgTypes[1].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*LocationStatus); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_proto_oltp20_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   2,
			NumExtensions: 0,
			NumServices:   1,
		},
		GoTypes:           file_proto_oltp20_proto_goTypes,
		DependencyIndexes: file_proto_oltp20_proto_depIdxs,
		MessageInfos:      file_proto_oltp20_proto_msgTypes,
	}.Build()
	File_proto_oltp20_proto = out.File
	file_proto_oltp20_proto_rawDesc = nil
	file_proto_oltp20_proto_goTypes = nil
	file_proto_oltp20_proto_depIdxs = nil
}

// Reference imports to suppress errors if they are not otherwise used.
var _ context.Context
var _ grpc.ClientConnInterface

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
const _ = grpc.SupportPackageIsVersion6

// OLTP20ServiceClient is the client API for OLTP20Service service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
type OLTP20ServiceClient interface {
	LocationNotification(ctx context.Context, in *StageLocation, opts ...grpc.CallOption) (*LocationStatus, error)
}

type oLTP20ServiceClient struct {
	cc grpc.ClientConnInterface
}

func NewOLTP20ServiceClient(cc grpc.ClientConnInterface) OLTP20ServiceClient {
	return &oLTP20ServiceClient{cc}
}

func (c *oLTP20ServiceClient) LocationNotification(ctx context.Context, in *StageLocation, opts ...grpc.CallOption) (*LocationStatus, error) {
	out := new(LocationStatus)
	err := c.cc.Invoke(ctx, "/oltp20.OLTP20Service/LocationNotification", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// OLTP20ServiceServer is the server API for OLTP20Service service.
type OLTP20ServiceServer interface {
	LocationNotification(context.Context, *StageLocation) (*LocationStatus, error)
}

// UnimplementedOLTP20ServiceServer can be embedded to have forward compatible implementations.
type UnimplementedOLTP20ServiceServer struct {
}

func (*UnimplementedOLTP20ServiceServer) LocationNotification(context.Context, *StageLocation) (*LocationStatus, error) {
	return nil, status.Errorf(codes.Unimplemented, "method LocationNotification not implemented")
}

func RegisterOLTP20ServiceServer(s *grpc.Server, srv OLTP20ServiceServer) {
	s.RegisterService(&_OLTP20Service_serviceDesc, srv)
}

func _OLTP20Service_LocationNotification_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(StageLocation)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(OLTP20ServiceServer).LocationNotification(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/oltp20.OLTP20Service/LocationNotification",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(OLTP20ServiceServer).LocationNotification(ctx, req.(*StageLocation))
	}
	return interceptor(ctx, in, info, handler)
}

var _OLTP20Service_serviceDesc = grpc.ServiceDesc{
	ServiceName: "oltp20.OLTP20Service",
	HandlerType: (*OLTP20ServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "LocationNotification",
			Handler:    _OLTP20Service_LocationNotification_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "proto/oltp20.proto",
}
