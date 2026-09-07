import { Link } from 'react-router-dom'
import './JobCard.css'

function JobCard({ job }) {
  return (
    <article className="job-card">
      <h2>{job.title}</h2>
      <p className="company">{job.company}</p>
      <p className="description">{job.description}</p>
      <Link to={`/jobs/${job.id}`}>
        View Job
      </Link>
    </article>
  )
}

export default JobCard