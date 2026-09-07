import { BrowserRouter, Routes, Route } from 'react-router-dom'
import NavBar from './components/NavBar'
import HomePage from './pages/HomePage'
import JobsPage from './features/jobs/JobsPage'
import JobForm from './features/jobs/JobForm'

function App() {
  return (
    <BrowserRouter>
      <NavBar />

      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/jobs" element={<JobsPage />} />
        <Route path="/jobs/new" element={<JobForm />} />
      </Routes>
    </BrowserRouter>
  )
}

export default App