import { Link } from 'react-router-dom'
import './NavBar.css'

function NavBar() {
  return (
    <nav className="navbar">
      <Link className="navbar-brand" to="/">
        Career Coach
      </Link>

      <div className="navbar-links">
        <details>
          <summary>Jobs</summary>

          <div className="navbar-dropdown">
            <Link to="/jobs">Index</Link>
            <Link to="/jobs/new">Create new job</Link>
          </div>
        </details>
      </div>
    </nav>
  )
}

export default NavBar