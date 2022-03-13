import "vertex"
import "triangle"

Tris = {
  Triangle.new(
    Vertex.new(50, 50, 50 ),
    Vertex.new(-50, -50, 50 ),
    Vertex.new(-50, 50, -50 ),
    { 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55 }
  ),
  Triangle.new(
    Vertex.new(50, 50, 50 ),
    Vertex.new(-50, -50, 50 ),
    Vertex.new(50, -50, -50 ),
    { 0x00, 0x55, 0x00, 0x55, 0x00, 0x55, 0x00, 0x55 }
  ),
  Triangle.new(
    Vertex.new(-50, 50, -50 ),
    Vertex.new(50, -50, -50 ),
    Vertex.new(50, 50, 50 ),
    { 0xaa, 0x00, 0xaa, 0x00, 0xaa, 0x00, 0xaa, 0x00 }
  ),
  Triangle.new(
    Vertex.new(-50, 50, -50 ),
    Vertex.new(50, -50, -50 ),
    Vertex.new(50, 50, 50 ),
    { 0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 0x00 }
  ),
}