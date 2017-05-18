package myPackage

type M struct {
	Name string
}

func (m *M)P() {
	println(m.Name)
	p("package")
}