module MySpecChecker
def check_content(c)
it { should have_content(c) }
end

def check_title(t)
it { should have_title(t) }
end

def test_link(link)
   expect(page).to have_title(full_title(link))
end
end